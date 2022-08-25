defmodule Baz.CollectionAssetImports.Jobs.PullCollectionAssetsByPage do
  @moduledoc """
  Fetch collection asset data from a venue and normalize before passing through the sink pipeline
  """

  use Oban.Worker, queue: :imports
  import Baz.FormatLogger

  defmodule Input do
    defstruct ~w[import sinks page_number page_cursor]a
  end

  @impl Oban.Worker
  def perform(%Oban.Job{
        args: %{
          "collection_asset_import_id" => import_id,
          "page_number" => page_number,
          "page_cursor" => page_cursor
        }
      }) do
    asset_import = Baz.CollectionAssetImports.get_collection_asset_import!(import_id)
    asset_sinks = Baz.NormalizedSinks.get_collection_asset_normalized_sinks()

    %Input{
      import: asset_import,
      sinks: asset_sinks,
      page_number: page_number,
      page_cursor: page_cursor
    }
    |> ensure_import_started()
    |> fetch_and_upsert()
    |> enqueue_next_page()
    |> complete_import_on_last_page()
  rescue
    e ->
      "unhandled error pulling collection assets error=~s, stacktrace=~s"
      |> log_error([inspect(e), inspect(__STACKTRACE__)])
  end

  defp ensure_import_started(input) do
    input =
      if input.page_number == 0 do
        "start execution of collection assets import id=~w" |> log_info([input.import.id])
        {:ok, asset_import} = update_import_status(input.import, "executing")
        %{input | import: asset_import}
      else
        input
      end

    "pull collection assets by page import id=~w, page_number=~w"
    |> log_info([input.import.id, input.page_number])

    input
  end

  defp fetch_and_upsert(input) do
    case fetch(input.import, input.page_cursor) do
      %Baz.Page{} = page ->
        multi = Ecto.Multi.new()

        import_page_attrs = %{
          page_number: input.page_number,
          next_page_cursor: page.next_page_cursor
        }

        import_page = Ecto.build_assoc(input.import, :pages, import_page_attrs)
        multi = Ecto.Multi.insert(multi, :import_page, import_page)

        multi =
          page.data
          |> Enum.with_index()
          |> Enum.reduce(
            multi,
            fn {asset, index}, multi ->
              Ecto.Multi.insert(multi, {:collection_asset, index}, asset)
            end
          )

        result = input.sinks |> Enum.map(fn s -> s.receive_collection_asset_import(multi) end)

        {input, {:ok, result}, import_page}

      {:error, reason} = error ->
        "could not fetch collection assets venue=~s, slug=~s, token_ids: ~w, reason=~s"
        |> log_error([
          input.import.venue,
          input.import.slug,
          input.import.token_ids,
          reason |> inspect
        ])

        # TODO: how should this match import_page above?
        # - should retry
        # - only really needs the next cursor or current cursor
        # - page number can come from itself
        {input, error}
    end
  end

  defp enqueue_next_page({input, _fetch_and_upsert_result, import_page} = step_input) do
    if import_page.next_page_cursor != nil do
      %{
        collection_asset_import_id: input.import.id,
        page_number: import_page.page_number + 1,
        page_cursor: import_page.next_page_cursor
      }
      |> Baz.CollectionAssetImports.Jobs.PullCollectionAssetsByPage.new()
      |> Oban.insert()
    end

    step_input
  end

  defp complete_import_on_last_page({input, fetch_and_upsert_result, import_page}) do
    unless import_page.next_page_cursor do
      "complete execution of collection assets import id=~w" |> log_info([input.import.id])
      {:ok, _asset_import} = update_import_status(input.import, "completed")
    end

    fetch_and_upsert_result
  end

  defp update_import_status(asset_import, status) do
    Baz.CollectionAssetImports.update_collection_asset_import(asset_import, %{status: status})
  end

  defp fetch(asset_import, page_cursor) do
    try do
      venue = Baz.Venues.get_venue!(asset_import.venue)

      Baz.VenueAdapter.fetch_collection_asset_page_by_slug(
        venue,
        asset_import.slug,
        asset_import.token_ids,
        page_cursor
      )
    rescue
      reason -> {:error, reason}
    end
  end
end

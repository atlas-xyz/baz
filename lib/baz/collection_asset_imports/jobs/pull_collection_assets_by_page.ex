defmodule Baz.CollectionAssetImports.Jobs.PullCollectionAssetsByPage do
  @moduledoc """
  TODO...
  """

  use Oban.Worker, queue: :imports
  require Logger

  alias Baz.Repo

  @impl Oban.Worker
  def perform(%Oban.Job{
        args: %{
          "collection_asset_import_id" => import_id,
          "page_number" => page_number,
          "page_cursor" => page_cursor
        }
      }) do
    collection_asset_import = Baz.CollectionAssetImports.get_collection_asset_import!(import_id)
    result = fetch_and_upsert_collection_assets(collection_asset_import, page_number, page_cursor)
    result
  rescue
    e ->
      "unhandled error pulling collection assets error=~s, stacktrace=~s"
      |> :io_lib.format([
        e |> inspect,
        __STACKTRACE__ |> inspect
      ])
      |> Logger.error()
  end

  defp fetch_and_upsert_collection_assets(asset_import, current_page_number, current_page_cursor) do
    case fetch_asset_page(asset_import, current_page_cursor) do
      %Baz.Page{} = page ->
        import_page_attrs = %{
          page_number: current_page_number,
          next_page_cursor: page.next_page_cursor
        }

        import_page = Ecto.build_assoc(asset_import, :pages, import_page_attrs)

        multi =
          Ecto.Multi.new()
          |> Ecto.Multi.insert(
            :import_page,
            import_page
          )

        page.data
        |> Enum.with_index()
        |> Enum.reduce(
          multi,
          fn {asset, index}, multi ->
            # TODO: how can this save the traits if the asset hasn't been saved and assigned an id???
            # TODO: support multiple strategies
            # - :nothing
            # - :replace
            Ecto.Multi.insert(
              multi,
              {:collection_asset, index},
              asset
            )
          end
        )
        |> Repo.transaction()

        if import_page.next_page_cursor != nil do
          # TODO: Extract out into facade function
          %{
            collection_asset_import_id: asset_import.id,
            page_number: import_page.page_number + 1,
            page_cursor: import_page.next_page_cursor
          }
          |> Baz.CollectionAssetImports.Jobs.PullCollectionAssetsByPage.new()
          |> Oban.insert()
        end

        :ok

      {:error, reason} = error ->
        "could not retrieve collection assets slug=~s, venue=~s, token_ids: ~w, reason=~s"
        |> :io_lib.format([
          asset_import.slug,
          asset_import.venue,
          asset_import.token_ids,
          reason |> inspect
        ])
        |> Logger.error()

        error
    end
  end

  # defp update_import_status(collection_asset_import, status) do
  #   Baz.CollectionAssetImports.update_collection_asset_import(collection_asset_import, %{status: status})
  # end

  defp fetch_asset_page(asset_import, page_cursor) do
    venue = Baz.Venues.get_venue!(asset_import.venue)

    Baz.VenueAdapter.fetch_collection_asset_page_by_slug(
      venue,
      asset_import.slug,
      asset_import.token_ids,
      page_cursor
    )
  end
end

defmodule Baz.CollectionEventImports.Jobs.PullCollectionEventsByPage do
  @moduledoc """
  TODO...
  """

  use Oban.Worker, queue: :imports
  require Logger

  alias Baz.Repo

  @impl Oban.Worker
  def perform(%Oban.Job{
        args: %{
          "collection_event_import_id" => import_id,
          "page_number" => page_number,
          "page_cursor" => page_cursor
        }
      }) do
    collection_event_import = Baz.CollectionEventImports.get_collection_event_import!(import_id)
    result = fetch_and_upsert_collection_events(collection_event_import, page_number, page_cursor)
    result
  rescue
    e ->
      "unhandled error pulling collection events error=~s, stacktrace=~s"
      |> :io_lib.format([
        e |> inspect,
        __STACKTRACE__ |> inspect
      ])
      |> Logger.error()
  end

  defp fetch_and_upsert_collection_events(event_import, current_page_number, current_page_cursor) do
    case fetch_event_page(event_import, current_page_cursor) do
      %Baz.Page{} = page ->
        import_page_attrs = %{
          page_number: current_page_number,
          next_page_cursor: page.next_page_cursor
        }

        import_page = Ecto.build_assoc(event_import, :pages, import_page_attrs)

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
          fn {event, index}, multi ->
            # TODO: support multiple strategies
            # - :nothing
            # - :replace
            Ecto.Multi.insert(
              multi,
              {:collection_event, index},
              event
            )
          end
        )
        |> Repo.transaction()

        if import_page.next_page_cursor != nil do
          # TODO: Extract out into facade function
          %{
            collection_event_import_id: event_import.id,
            page_number: import_page.page_number + 1,
            page_cursor: import_page.next_page_cursor
          }
          |> Baz.CollectionEventImports.Jobs.PullCollectionEventsByPage.new()
          |> Oban.insert()
        end

        :ok

      {:error, reason} = error ->
        "could not retrieve collection events slug=~s, venue=~s, token_ids: ~w, reason=~s"
        |> :io_lib.format([
          event_import.slug,
          event_import.venue,
          event_import.token_ids,
          reason |> inspect
        ])
        |> Logger.error()

        error
    end
  end

  # defp update_import_status(collection_event_import, status) do
  #   Baz.CollectionEventImports.update_collection_event_import(collection_event_import, %{status: status})
  # end

  defp fetch_event_page(event_import, page_cursor) do
    venue = Baz.Venues.get_venue!(event_import.venue)

    Baz.VenueAdapter.fetch_collection_event_page_by_slug(
      venue,
      event_import.slug,
      event_import.token_ids,
      page_cursor
    )
  end
end

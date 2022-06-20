defmodule Baz.CollectionEventImports.Jobs.PullCollectionEvents do
  @moduledoc """
  Fetches the collection events, a page at a time matching the import filters:

  - before
  - after
  - token_ids
  - event_types
  """

  use Oban.Worker, queue: :imports
  require Logger

  @impl Oban.Worker
  def perform(%Oban.Job{args: %{"collection_event_import_id" => import_id}}) do
    collection_event_import = Baz.CollectionEventImports.get_collection_event_import!(import_id)
    {:ok, _collection_event_import} = update_import_status(collection_event_import, "executing")

    %{collection_event_import_id: import_id, page_number: 0, page_cursor: nil}
    |> Baz.CollectionEventImports.Jobs.PullCollectionEventsByPage.new()
    |> Oban.insert()
  rescue
    e ->
      "unhandled error retrieving collection events error=~s, stacktrace=~s"
      |> :io_lib.format([
        e |> inspect,
        __STACKTRACE__ |> inspect
      ])
      |> Logger.error()
  end

  defp update_import_status(collection_event_import, status) do
    Baz.CollectionEventImports.update_collection_event_import(collection_event_import, %{
      status: status
    })
  end
end

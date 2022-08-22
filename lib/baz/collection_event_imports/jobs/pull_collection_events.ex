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
    event_import = Baz.CollectionEventImports.get_collection_event_import!(import_id)

    %{collection_event_import_id: event_import.id, page_number: 0, page_cursor: nil}
    |> Baz.CollectionEventImports.Jobs.PullCollectionEventsByPage.new()
    |> Oban.insert()
  rescue
    e ->
      "unhandled error pulling collection events error=~s, stacktrace=~s"
      |> format_log_error([inspect(e), inspect(__STACKTRACE__)])
  end

  defp format_log_error(format, data) do
    format
    |> :io_lib.format(data)
    |> Logger.error()
  end
end

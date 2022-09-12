defmodule Baz.CollectionImports.Jobs.PullCollection do
  @moduledoc """
  Fetch collection data from a venue and normalize before passing through the sink pipeline
  """

  use Oban.Worker, queue: :pull
  import Baz.FormatLogger

  defmodule Input do
    defstruct ~w[import sinks]a
  end

  @impl Oban.Worker
  def perform(%Oban.Job{args: %{"id" => id}}) do
    collection_import = Baz.CollectionImports.get_collection_import!(id)
    collection_sinks = Baz.NormalizedSinks.get_collection_normalized_sinks()

    %Input{
      import: collection_import,
      sinks: collection_sinks
    }
    |> start_import()
    |> fetch_and_upsert()
    |> complete_import()
  rescue
    e ->
      "unhandled error pulling collection error=~s, stacktrace=~s"
      |> log_error([inspect(e), inspect(__STACKTRACE__)])
  end

  defp start_import(input) do
    "start execution of collection import id=~s" |> log_info([input.import.id])
    {:ok, collection_import} = update_import_status(input.import, "executing")
    %{input | import: collection_import}
  end

  defp fetch_and_upsert(input) do
    case fetch(input.import) do
      %Ecto.Changeset{} = changeset ->
        result = input.sinks |> Enum.map(fn s -> s.receive_collection_import(changeset) end)
        {input, {:ok, result}}

      {:error, reason} = error ->
        "could not fetch collection from venue=~s, slug=~s, reason=~s"
        |> log_error([input.import.venue, input.import.slug, inspect(reason)])

        {input, error}
    end
  end

  defp complete_import({input, fetch_and_upsert_result}) do
    "complete execution of collection import id=~s" |> log_info([input.import.id])
    {:ok, _collection_import} = update_import_status(input.import, "completed")
    fetch_and_upsert_result
  end

  defp update_import_status(collection_import, status) do
    Baz.CollectionImports.update_collection_import(collection_import, %{status: status})
  end

  defp fetch(collection_import) do
    try do
      venue = Baz.Venues.get_venue!(collection_import.venue)

      Baz.VenueAdapter.fetch_collection_by_slug(
        venue,
        collection_import.slug
      )
    rescue
      reason -> {:error, reason}
    end
  end
end

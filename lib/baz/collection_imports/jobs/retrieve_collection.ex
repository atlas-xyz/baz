defmodule Baz.CollectionImports.Jobs.RetrieveCollection do
  use Oban.Worker, queue: :imports
  require Logger
  alias Baz.Repo

  defmodule Input do
    defstruct ~w[import sinks]a
  end

  @impl Oban.Worker
  def perform(%Oban.Job{args: %{"id" => id}}) do
    collection_import = Baz.CollectionImports.get_collection_import!(id)
    collection_sinks = Baz.Sinks.get_collection_sinks()

    %Input{
      import: collection_import,
      sinks: collection_sinks
    }
    |> start_import()
    |> fetch_and_upsert()
    |> complete_import()
  rescue
    e ->
      "unhandled error retrieving collection error=~s, stacktrace=~s"
      |> format_log_error([inspect(e), inspect(__STACKTRACE__)])
  end

  defp start_import(input) do
    {:ok, collection_import} = update_import_status(input.import, "executing")
    %{input | import: collection_import}
  end

  defp fetch_and_upsert(input) do
    venue_name = input.import.venue
    slug = input.import.slug
    venue = Baz.Venues.get_venue!(venue_name)

    case Baz.VenueAdapter.fetch_collection_by_slug(venue, slug) do
      %Ecto.Changeset{} = changeset ->
        # input.collection_sinks
        result = Repo.insert(changeset, on_conflict: :nothing)
        {input, result}

      {:error, reason} = error ->
        "could not retrieve collection venue=~s, slug=~s, reason=~s"
        |> format_log_error([venue_name, slug, inspect(reason)])

        {input, error}
    end
  end

  defp complete_import({input, fetch_and_upsert_result}) do
    {:ok, _collection_import} = update_import_status(input.import, "completed")
    fetch_and_upsert_result
  end

  defp update_import_status(collection_import, status) do
    Baz.CollectionImports.update_collection_import(collection_import, %{status: status})
  end

  defp format_log_error(format, data) do
    format
    |> :io_lib.format(data)
    |> Logger.error()
  end
end

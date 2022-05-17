defmodule Baz.CollectionImports.Jobs.RetrieveCollection do
  use Oban.Worker, queue: :imports
  require Logger
  alias Baz.Repo

  @impl Oban.Worker
  def perform(%Oban.Job{args: %{"id" => id}}) do
    collection_import = Baz.CollectionImports.get_collection_import!(id)
    {:ok, collection_import} = update_import_status(collection_import, "executing")
    result = get_and_upsert_collection(collection_import)
    {:ok, _collection_import} = update_import_status(collection_import, "completed")

    result
  rescue
    e ->
      "unhandled error retrieving collection error=~s, stacktrace=~s"
      |> :io_lib.format([
        e |> inspect,
        __STACKTRACE__ |> inspect
      ])
      |> Logger.error()
  end

  defp get_and_upsert_collection(collection_import) do
    venue = Baz.Venues.get_venue!(collection_import.venue)

    case Baz.VenueAdapter.get_collection_by_slug(venue, collection_import.slug) do
      %Ecto.Changeset{} = changeset ->
        # TODO: support multiple strategies
        # - :nothing
        # - :replace
        Repo.insert(changeset, on_conflict: :nothing)

      {:error, reason} = error ->
        "could not retrieve collection slug=~s, venue=~s, reason=~s"
        |> :io_lib.format([
          collection_import.slug,
          venue.name,
          reason |> inspect
        ])
        |> Logger.error()

        error
    end
  end

  defp update_import_status(collection_import, status) do
    Baz.CollectionImports.update_collection_import(collection_import, %{status: status})
  end
end

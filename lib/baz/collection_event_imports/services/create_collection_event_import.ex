defmodule Baz.CollectionEventImports.Services.CreateCollectionEventImport do
  alias Baz.CollectionEventImports
  alias Baz.Repo

  @type attrs :: map
  @type error_reason :: term
  @type collection_event_import :: CollectionEventImports.CollectionEventImport.t()

  @spec call(attrs) :: {:ok, collection_event_import} | {:error, error_reason}
  def call(attrs) do
    attrs = build_attrs(attrs)

    %CollectionEventImports.CollectionEventImport{}
    |> CollectionEventImports.CollectionEventImport.changeset(attrs)
    |> Repo.insert()
    |> case do
      {:ok, event_import} ->
        insert_job(event_import)
        {:ok, event_import}

      error ->
        error
    end
  end

  @one_week_in_seconds 7 * 24 * 60 * 60
  defp build_attrs(attrs) do
    before = DateTime.utc_now()

    %{
      "status" => "available",
      "before" => before,
      "after" => before |> DateTime.add(-@one_week_in_seconds, :second)
    }
    |> Map.merge(attrs)
  end

  defp insert_job(event_import) do
    %{collection_event_import_id: event_import.id}
    |> CollectionEventImports.Jobs.PullCollectionEvents.new()
    |> Oban.insert()
  end
end

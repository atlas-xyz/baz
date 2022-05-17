defmodule Baz.CollectionImports.Services.CreateCollectionImport do
  alias Baz.CollectionImports
  alias Baz.Repo

  @type attrs :: map
  @type error_reason :: term
  @type collection_import :: struct

  @spec call(attrs) :: {:ok, collection_import} | {:error, error_reason}
  def call(attrs) do
    attrs = build_attrs(attrs)

    %CollectionImports.CollectionImport{}
    |> CollectionImports.CollectionImport.changeset(attrs)
    |> Repo.insert()
    |> case do
      {:ok, collection_import} ->
        insert_job(collection_import)
        {:ok, collection_import}

      error ->
        error
    end
  end

  defp build_attrs(attrs) do
    Map.merge(attrs, %{"status" => "available"})
  end

  defp insert_job(collection_import) do
    %{id: collection_import.id}
    |> CollectionImports.Jobs.RetrieveCollection.new()
    |> Oban.insert()
  end
end

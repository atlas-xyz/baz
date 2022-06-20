defmodule Baz.TestSupport.Factories.CollectionEventImportFactory do
  alias Baz.Repo
  alias Baz.CollectionEventImports

  @type collection_event_import :: CollectionEventImports.CollectionEventImport.t()

  @spec create_collection_event_import(map) ::
          {:ok, collection_event_import} | {:error, Ecto.Changeset.t()}
  def create_collection_event_import(attrs) do
    %CollectionEventImports.CollectionEventImport{}
    |> CollectionEventImports.CollectionEventImport.changeset(attrs)
    |> Repo.insert()
  end
end

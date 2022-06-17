defmodule Baz.TestSupport.Factories.CollectionImportFactory do
  @spec create_collection_import(map) :: {:ok, Ecto.Schema.t()} | {:error, Ecto.Changeset.t()}
  def create_collection_import(attrs) do
    %Baz.CollectionImports.CollectionImport{}
    |> Baz.CollectionImports.CollectionImport.changeset(attrs)
    |> Baz.Repo.insert()
  end
end

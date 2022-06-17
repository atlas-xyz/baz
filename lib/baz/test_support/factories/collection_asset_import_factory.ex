defmodule Baz.TestSupport.Factories.CollectionAssetImportFactory do
  @spec create_collection_asset_import(map) ::
          {:ok, Ecto.Schema.t()} | {:error, Ecto.Changeset.t()}
  def create_collection_asset_import(attrs) do
    %Baz.CollectionAssetImports.CollectionAssetImport{}
    |> Baz.CollectionAssetImports.CollectionAssetImport.changeset(attrs)
    |> Baz.Repo.insert()
  end
end

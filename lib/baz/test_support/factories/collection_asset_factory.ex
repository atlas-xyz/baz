defmodule Baz.TestSupport.Factories.CollectionAssetFactory do
  @spec create_collection_asset(map) :: {:ok, Ecto.Schema.t()} | {:error, Ecto.Changeset.t()}
  def create_collection_asset(attrs) do
    %Baz.CollectionAssets.CollectionAsset{}
    |> Baz.CollectionAssets.CollectionAsset.changeset(attrs)
    |> Baz.Repo.insert()
  end
end

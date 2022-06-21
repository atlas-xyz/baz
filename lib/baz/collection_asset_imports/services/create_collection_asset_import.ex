defmodule Baz.CollectionAssetImports.Services.CreateCollectionAssetImport do
  alias Baz.CollectionAssetImports
  alias Baz.Repo

  @type attrs :: map
  @type error_reason :: term
  @type collection_asset_import :: CollectionAssetImports.CollectionAssetImport.t()

  @spec call(attrs) :: {:ok, collection_asset_import} | {:error, error_reason}
  def call(attrs) do
    attrs = build_attrs(attrs)

    %CollectionAssetImports.CollectionAssetImport{}
    |> CollectionAssetImports.CollectionAssetImport.changeset(attrs)
    |> Repo.insert()
    |> case do
      {:ok, asset_import} ->
        {:ok, _job} = insert_job(asset_import)
        {:ok, asset_import}

      error ->
        error
    end
  end

  defp build_attrs(attrs) do
    Map.merge(attrs, %{"status" => "available"})
  end

  defp insert_job(asset_import) do
    %{collection_asset_import_id: asset_import.id}
    |> CollectionAssetImports.Jobs.PullCollectionAssets.new()
    |> Oban.insert()
  end
end

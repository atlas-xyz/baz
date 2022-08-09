defmodule Baz.CollectionAssetImports do
  alias Baz.Repo
  alias Baz.CollectionAssetImports.CollectionAssetImport
  alias Baz.CollectionAssetImports.Queries
  alias Baz.CollectionAssetImports.Services

  @type where_opt :: Queries.FilterAndOrder.where_opt()
  @type order_opt :: Queries.FilterAndOrder.order_opt()
  @type collection_asset_import :: CollectionAssetImport.t()

  @type filter_and_order_opts :: [where_opt | order_opt]

  @doc """
  Gets collection_asset_imports that match the where clause sorted by the order clause.

  ## Examples

      iex> filter_and_order(where: [venue: "open_sea"], order: [desc: :venue])
      [%CollectionAssetImport{}]

  """
  @spec filter_and_order(filter_and_order_opts) :: [collection_asset_import]
  def filter_and_order(opts) do
    opts
    |> Queries.FilterAndOrder.new()
    |> Repo.all()
  end

  @doc """
  Gets a single collection_asset_import.

  Raises `Ecto.NoResultsError` if the CollectionAssetImport does not exist.

  ## Examples

      iex> get_collection_asset_import!(123)
      %CollectionAssetImport{}

      iex> get_collection_asset_import!(456)
      ** (Ecto.NoResultsError)

  """
  @spec get_collection_asset_import!(term) :: term
  def get_collection_asset_import!(id), do: Repo.get!(CollectionAssetImport, id)

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking collection_asset_import changes.

  ## Examples

      iex> change_collection_asset_import(collection_asset_import)
      %Ecto.Changeset{data: %CollectionAssetImport{}}

  """
  @spec change_collection_asset_import(collection_asset_import, map) :: Ecto.Changeset.t()
  def change_collection_asset_import(collection_asset_import, attrs \\ %{}) do
    CollectionAssetImport.changeset(collection_asset_import, attrs)
  end

  @type create_attrs :: Services.CreateCollectionAssetImport.attrs()
  @spec create_collection_asset_import(create_attrs) :: {:ok, collection_asset_import} | {:error, Services.CreateCollectionAssetImport.error_reason()}
  def create_collection_asset_import(attrs) do
    Services.CreateCollectionAssetImport.call(attrs)
  end

  @doc """
  Updates a collection_asset_import.

  ## Examples

      iex> update_collection_asset_import(collection_asset_import, %{field: new_value})
      {:ok, %CollectionAssetImport{}}

      iex> update_collection_asset_import(collection_asset_import, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  @spec update_collection_asset_import(collection_asset_import, map) :: {:ok, collection_asset_import} | {:error, Ecto.Changeset.t()}
  def update_collection_asset_import(%CollectionAssetImport{} = collection_asset_import, attrs) do
    collection_asset_import
    |> CollectionAssetImport.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a collection_asset_import.

  ## Examples

      iex> delete_collection_asset_import(collection_asset_import)
      {:ok, %CollectionAssetImport{}}

      iex> delete_collection_asset_import(collection_asset_import)
      {:error, %Ecto.Changeset{}}

  """
  def delete_collection_asset_import(%CollectionAssetImport{} = collection_asset_import) do
    Repo.delete(collection_asset_import)
  end
end

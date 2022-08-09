defmodule Baz.CollectionAssets do
  alias Baz.Repo
  alias Baz.CollectionAssets.CollectionAsset
  alias Baz.CollectionAssets.Queries

  @type where_opt :: Queries.FilterAndOrder.where_opt()
  @type order_opt :: Queries.FilterAndOrder.order_opt()
  @type collection_asset :: CollectionAsset.t()

  @type filter_and_order_opts :: [where_opt | order_opt]

  @doc """
  Gets collection_assets that match the where clause sorted by the order clause.

  ## Examples

      iex> filter_and_order(where: [venue: "open_sea"], order: [desc: :venue])
      [%CollectionAsset{}]

  """
  @spec filter_and_order(filter_and_order_opts) :: [collection_asset]
  def filter_and_order(opts) do
    opts
    |> Queries.FilterAndOrder.new()
    |> Repo.all()
  end

  @doc """
  Gets a single collection_asset.

  Raises `Ecto.NoResultsError` if the Collection does not exist.

  ## Examples

      iex> get_collection_asset!(123)
      %CollectionAsset{}

      iex> get_collection_asset!(456)
      ** (Ecto.NoResultsError)

  """
  @spec get_collection_asset!(term) :: term
  def get_collection_asset!(id), do: Repo.get!(CollectionAsset, id)

  @spec collection_asset_changeset(map) :: Ecto.Changeset.t() | {:error, term}
  def collection_asset_changeset(attrs) do
    CollectionAsset.changeset(%CollectionAsset{}, attrs)
  end

  @spec create_collection_asset(map) :: {:ok, collection_asset} | {:error, term}
  def create_collection_asset(attrs) do
    %CollectionAsset{}
    |> CollectionAsset.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Deletes a collection_asset.

  ## Examples

      iex> delete_collection_asset(collection_asset)
      {:ok, %CollectionAsset{}}

      iex> delete_collection_asset(collection_asset)
      {:error, %Ecto.Changeset{}}

  """
  def delete_collection_asset(%CollectionAsset{} = collection_asset) do
    Repo.delete(collection_asset)
  end
end

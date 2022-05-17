defmodule Baz.CollectionAssets do
  alias Baz.Repo
  alias Baz.CollectionAssets.CollectionAsset
  alias Baz.CollectionAssets.Queries

  @type where_opt :: {:where, [{atom, term}]}
  @type order_opt :: {:order, [atom]}
  @type collection_asset :: struct

  @type filter_and_order_opts :: [where_opt | order_opt]
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
end

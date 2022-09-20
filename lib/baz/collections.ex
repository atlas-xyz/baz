defmodule Baz.Collections do
  @moduledoc false

  import Ecto.Query
  alias Baz.Repo
  alias Baz.Collections.Collection
  alias Baz.Collections.Queries

  @type collection :: Collection.t()

  @type search_query :: Queries.Search.search_query()
  @type page_number :: non_neg_integer
  @type page_size :: non_neg_integer

  @spec search_collections(search_query, page_number, page_size) :: [collection]
  def search_collections(search_query, page_number, page_size) do
    offset_page = max(page_number - 1, 0) * page_size

    queryable =
      search_query
      |> Queries.Search.new()
      |> limit(^page_size)
      |> offset(^offset_page)

    Repo.all(queryable)
  end

  @spec search_collections_count(search_query) :: non_neg_integer
  def search_collections_count(search_query) do
    queryable = Queries.Search.new(search_query)
    Repo.aggregate(queryable, :count)
  end

  @type where_opt :: {:where, [{atom, term}]}
  @type order_opt :: {:order, [atom]}

  @type filter_and_order_opts :: [where_opt | order_opt]
  @spec filter_and_order(filter_and_order_opts) :: [collection]
  def filter_and_order(opts) do
    opts
    |> Queries.FilterAndOrder.new()
    |> Repo.all()
  end

  @doc """
  Gets a single collection.

  Raises `Ecto.NoResultsError` if the Collection does not exist.

  ## Examples

      iex> get_collection!(123)
      %Collection{}

      iex> get_collection!(456)
      ** (Ecto.NoResultsError)

  """
  @spec get_collection!(term) :: collection
  def get_collection!(id), do: Repo.get!(Collection, id)

  @spec collection_changeset(map) :: Ecto.Changeset.t() | {:error, term}
  def collection_changeset(attrs) do
    Collection.changeset(%Collection{}, attrs)
  end

  @type create_attrs :: map
  @spec create_collection(create_attrs) :: {:ok, collection} | {:error, term}
  def create_collection(attrs) do
    %Collection{}
    |> Collection.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Deletes a collection.

  ## Examples

      iex> delete_collection(collection)
      {:ok, %Collection{}}

      iex> delete_collection(collection)
      {:error, %Ecto.Changeset{}}

  """
  def delete_collection(%Collection{} = collection) do
    Repo.delete(collection)
  end
end

defmodule Baz.Collections do
  alias Baz.Repo
  alias Baz.Collections.Collection
  alias Baz.Collections.Queries

  @type where_opt :: {:where, [{atom, term}]}
  @type order_opt :: {:order, [atom]}
  @type collection :: struct

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

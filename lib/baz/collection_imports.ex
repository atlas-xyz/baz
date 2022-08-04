defmodule Baz.CollectionImports do
  alias Baz.Repo
  alias Baz.CollectionImports.CollectionImport
  alias Baz.CollectionImports.Queries
  alias Baz.CollectionImports.Services

  @type where_opt :: {:where, [{atom, term}]}
  @type order_opt :: {:order, [atom]}
  @type collection_import :: CollectionImport.t()

  @type filter_and_order_opts :: [where_opt | order_opt]
  @spec filter_and_order(filter_and_order_opts) :: [collection_import]
  def filter_and_order(opts) do
    opts
    |> Queries.FilterAndOrder.new()
    |> Repo.all()
  end

  @doc """
  Gets a single collection_import.

  Raises `Ecto.NoResultsError` if the CollectionImport does not exist.

  ## Examples

      iex> get_collection_import!(123)
      %CollectionImport{}

      iex> get_collection_import!(456)
      ** (Ecto.NoResultsError)

  """
  @spec get_collection_import!(term) :: term
  def get_collection_import!(id), do: Repo.get!(CollectionImport, id)

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking collection_import changes.

  ## Examples

      iex> change_collection_import(collection_import)
      %Ecto.Changeset{data: %CollectionImport{}}

  """
  @spec change_collection_import(collection_import, map) :: Ecto.Changeset.t()
  def change_collection_import(collection_import, attrs \\ %{}) do
    CollectionImport.changeset(collection_import, attrs)
  end

  @type create_attrs :: Services.CreateCollectionImport.attrs()
  @spec create_collection_import(create_attrs) :: {:ok, collection_import} | {:error, Services.CreateCollectionImport.error_reason()}
  def create_collection_import(attrs) do
    Services.CreateCollectionImport.call(attrs)
  end

  @doc """
  Updates a collection_import.

  ## Examples

      iex> update_collection_import(collection_import, %{field: new_value})
      {:ok, %CollectionImport{}}

      iex> update_collection_import(collection_import, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  @spec update_collection_import(collection_import, map) :: {:ok, collection_import} | {:error, Ecto.Changeset.t()}
  def update_collection_import(%CollectionImport{} = collection_import, attrs) do
    collection_import
    |> CollectionImport.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a collection_import.

  ## Examples

      iex> delete_collection_import(collection_import)
      {:ok, %CollectionImport{}}

      iex> delete_collection_import(collection_import)
      {:error, %Ecto.Changeset{}}

  """
  def delete_collection_import(%CollectionImport{} = collection_import) do
    Repo.delete(collection_import)
  end
end

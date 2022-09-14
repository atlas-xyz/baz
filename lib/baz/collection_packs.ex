defmodule Baz.CollectionPacks do
  alias Baz.Repo
  alias Baz.CollectionPacks.CollectionPack
  alias Baz.CollectionPacks.Queries

  @type collection_pack :: CollectionPack.t()

  @type search_query :: String.t() | nil
  @type search_opts :: [{:page, pos_integer} | {:page_size, pos_integer}]

  @spec search_collection_packs(search_query, search_opts) :: [collection_pack]
  def search_collection_packs(_search_query, _opts) do
    # opts
    # |> Queries.FilterAndOrder.new()
    # |> Repo.all()

    Queries.Search.new()
    |> Repo.all()
  end

  @spec search_collection_packs_count(search_query, search_opts) :: non_neg_integer
  def search_collection_packs_count(_search_query, _opts) do
    Queries.Search.new()
    |> Repo.aggregate(:count)
  end

  @type where_opt :: {:where, [{atom, term}]}
  @type order_opt :: {:order, [atom]}

  @type filter_and_order_opts :: [where_opt | order_opt]
  @spec filter_and_order(filter_and_order_opts) :: [collection_pack]
  def filter_and_order(opts) do
    opts
    |> Queries.FilterAndOrder.new()
    |> Repo.all()
  end

  @doc """
  Gets a single collection_pack.

  Raises `Ecto.NoResultsError` if the CollectionPack does not exist.

  ## Examples

      iex> get_collection_pack!(123)
      %CollectionPack{}

      iex> get_collection_pack!(456)
      ** (Ecto.NoResultsError)

  """
  def get_collection_pack!(id), do: Repo.get!(CollectionPack, id)

  @doc """
  Creates a collection_pack.

  ## Examples

      iex> create_collection_pack(%{field: value})
      {:ok, %CollectionPack{}}

      iex> create_collection_pack(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_collection_pack(attrs \\ %{}) do
    %CollectionPack{}
    |> CollectionPack.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a collection_pack.

  ## Examples

      iex> update_collection_pack(collection_pack, %{field: new_value})
      {:ok, %CollectionPack{}}

      iex> update_collection_pack(collection_pack, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_collection_pack(%CollectionPack{} = collection_pack, attrs) do
    collection_pack
    |> CollectionPack.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking collection_pack changes.

  ## Examples

      iex> change_collection_pack(collection_pack)
      %Ecto.Changeset{data: %CollectionPack{}}

  """
  def change_collection_pack(%CollectionPack{} = collection_pack, attrs \\ %{}) do
    CollectionPack.changeset(collection_pack, attrs)
  end

  @doc """
  Deletes a collection_pack.

  ## Examples

      iex> delete_collection_pack(collection_pack)
      {:ok, %CollectionPack{}}

      iex> delete_collection_pack(collection_pack)
      {:error, %Ecto.Changeset{}}

  """
  def delete_collection_pack(%CollectionPack{} = collection_pack) do
    Repo.delete(collection_pack)
  end
end

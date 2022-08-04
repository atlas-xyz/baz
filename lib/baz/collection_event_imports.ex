defmodule Baz.CollectionEventImports do
  alias Baz.Repo
  alias Baz.CollectionEventImports.CollectionEventImport
  alias Baz.CollectionEventImports.Queries
  alias Baz.CollectionEventImports.Services

  @type where_opt :: {:where, [{atom, term}]}
  @type order_opt :: {:order, [atom]}
  @type collection_event_import :: CollectionEventImport.t()

  @type filter_and_order_opts :: [where_opt | order_opt]
  @spec filter_and_order(filter_and_order_opts) :: [collection_event_import]
  def filter_and_order(opts) do
    opts
    |> Queries.FilterAndOrder.new()
    |> Repo.all()
  end

  @doc """
  Gets a single collection_event_import.

  Raises `Ecto.NoResultsError` if the CollectionEventImport does not exist.

  ## Examples

      iex> get_collection_event_import!("open_sea")
      %CollectionEventImport{}

      iex> get_collection_event_import!("open_zea")
      ** (Ecto.NoResultsError)

  """
  @spec get_collection_event_import!(non_neg_integer) :: collection_event_import
  def get_collection_event_import!(id), do: Repo.get_by!(CollectionEventImport, id: id)

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking collection_event_import changes.

  ## Examples

      iex> change_collection_event_import(collection_event_import)
      %Ecto.Changeset{data: %CollectionAssetImport{}}

  """
  @spec change_collection_event_import(collection_event_import, map) :: Ecto.Changeset.t()
  def change_collection_event_import(collection_event_import, attrs \\ %{}) do
    CollectionEventImport.changeset(collection_event_import, attrs)
  end

  @type create_attrs :: Services.CreateCollectionEventImport.attrs()
  @spec create_collection_event_import(create_attrs) ::
          {:ok, collection_event_import}
          | {:error, Services.CreateCollectionEventImport.error_reason()}
  def create_collection_event_import(attrs) do
    Services.CreateCollectionEventImport.call(attrs)
  end

  @doc """
  Updates a collection_event_import.

  ## Examples

      iex> update_collection_event_import(collection_event_import, %{field: new_value})
      {:ok, %CollectionEventImport{}}

      iex> update_collection_event_import(collection_event_import, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  @spec update_collection_event_import(collection_event_import, map) ::
          {:ok, collection_event_import} | {:error, Ecto.Changeset.t()}
  def update_collection_event_import(%CollectionEventImport{} = collection_event_import, attrs) do
    collection_event_import
    |> CollectionEventImport.changeset(attrs)
    |> Repo.update()
  end
end

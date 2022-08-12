defmodule Baz.CollectionEventImports do
  alias Baz.Repo
  alias Baz.CollectionEventImports.CollectionEventImport
  alias Baz.CollectionEventImports.Queries
  alias Baz.CollectionEventImports.Services

  @type collection_event_import :: CollectionEventImport.t()
  @type filter_and_order_opts :: Queries.FilterAndOrder.opts()

  @doc """
  Gets collection_assets that match the where clause sorted by the order clause.

  ## Examples

      iex> filter_and_order(where: [venue: "open_sea"], order: [desc: :venue])
      [%CollectionEventImport{}]

  """
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
  Returns a `%CollectionEventImport{}` initialized with a week before today date range

  ## Examples

      iex> collection_event_import_today(%{})
      %CollectionEventImport{}

  """
  @spec collection_event_import_today(map) :: collection_event_import
  def collection_event_import_today(params) do
    now = DateTime.utc_now()
    {:ok, date_now} = Date.new(now.year, now.month, now.day)
    {:ok, time_now} = Time.new(now.hour, 0, 0)
    {:ok, current_hour} = DateTime.new(date_now, time_now)
    after_date = current_hour |> Timex.shift(days: -7)
    before_date = current_hour |> Timex.shift(hours: 1)

    %CollectionEventImport{}
    |> Map.merge(params)
    |> Map.merge(%{
      after: after_date,
      before: before_date
    })
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking collection_event_import changes.

  ## Examples

      iex> change_collection_event_import(collection_event_import)
      %Ecto.Changeset{data: %CollectionEventImport{}}

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

  @doc """
  Deletes a collection_event_import.

  ## Examples

      iex> delete_collection_event_import(collection_event_import)
      {:ok, %CollectionEventImport{}}

      iex> delete_collection_event_import(collection_event_import)
      {:error, %Ecto.Changeset{}}

  """
  def delete_collection_event_import(%CollectionEventImport{} = collection_event_import) do
    Repo.delete(collection_event_import)
  end
end

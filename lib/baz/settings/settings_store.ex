defmodule Baz.Settings.SettingsStore do
  use GenServer

  @type store_id :: atom
  @type key :: atom
  @type value :: term

  @default_id :default
  @table_name :settings_store

  @spec start_link(keyword) :: GenServer.on_start()
  def start_link(args) do
    id = Keyword.get(args, :id, @default_id)
    name = process_name(id)

    GenServer.start_link(__MODULE__, [], name: name)
  end

  @spec process_name(store_id) :: atom
  def process_name(store_id), do: :"#{__MODULE__}_#{store_id}"

  @spec put(key, value) :: {:ok, {key, value}}
  def put(key, value, store_id \\ @default_id) do
    store_id
    |> process_name()
    |> GenServer.call({:put, key, value})
  end

  @type find_result :: {:ok, value} | {:error, :not_found}

  @spec find(key) :: find_result
  def find(key, _store_id \\ @default_id) do
    @table_name
    |> :ets.lookup(key)
    |> case do
      [{_, value} | _] -> {:ok, value}
      [] -> {:error, :not_found}
    end
  end

  @type all_result :: [{key, value}]

  @spec all :: all_result
  def all(_store_id \\ @default_id) do
    @table_name
    |> :ets.tab2list()
  end

  @impl true
  def init(state) do
    :ets.new(@table_name, [:set, :protected, :named_table])
    {:ok, state}
  end

  @impl true
  def handle_call({:put, key, value}, _from, state) do
    record = {key, value}
    true = :ets.insert(@table_name, record)
    {:reply, {:ok, record}, state}
  end
end

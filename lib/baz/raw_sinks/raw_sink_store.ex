defmodule Baz.RawSinks.RawSinkStore do
  use GenServer

  @type store_id :: atom
  @type key :: atom
  @type resource :: atom
  @type raw_sink :: module

  @default_id :default
  @table_name :raw_sink_store

  @spec start_link(keyword) :: GenServer.on_start()
  def start_link(args) do
    id = Keyword.get(args, :id, @default_id)
    name = process_name(id)

    GenServer.start_link(__MODULE__, [], name: name)
  end

  @spec process_name(store_id) :: atom
  def process_name(store_id), do: :"#{__MODULE__}_#{store_id}"

  @spec put(resource, [raw_sink]) :: {:ok, {resource, [raw_sink]}}
  def put(resource, raw_sinks, store_id \\ @default_id) do
    store_id
    |> process_name()
    |> GenServer.call({:put, resource, raw_sinks})
  end

  @spec find(resource) :: {:ok, [raw_sink]} | {:error, :not_found}
  def find(resource, _store_id \\ @default_id) do
    @table_name
    |> :ets.lookup(resource)
    |> case do
      [{_, raw_sinks} | _] ->
        {:ok, raw_sinks}

      [] ->
        {:error, :not_found}
    end
  end

  @impl true
  def init(state) do
    :ets.new(@table_name, [:set, :protected, :named_table])
    {:ok, state}
  end

  @impl true
  def handle_call({:put, resource, raw_sinks}, _from, state) do
    record = {resource, raw_sinks}
    true = :ets.insert(@table_name, record)
    {:reply, {:ok, record}, state}
  end
end

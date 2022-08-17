defmodule Baz.NormalizedSinks.NormalizedSinkStore do
  use GenServer

  @type store_id :: atom
  @type key :: atom
  @type resource :: atom
  @type normalized_sink :: module

  @default_id :default
  @table_name :normalized_sink_store

  @spec start_link(keyword) :: GenServer.on_start()
  def start_link(args) do
    id = Keyword.get(args, :id, @default_id)
    name = process_name(id)

    GenServer.start_link(__MODULE__, [], name: name)
  end

  @spec process_name(store_id) :: atom
  def process_name(store_id), do: :"#{__MODULE__}_#{store_id}"

  @spec put(resource, [normalized_sink]) :: {:ok, {resource, [normalized_sink]}}
  def put(resource, normalized_sinks, store_id \\ @default_id) do
    store_id
    |> process_name()
    |> GenServer.call({:put, resource, normalized_sinks})
  end

  @spec find(resource) :: {:ok, [normalized_sink]} | {:error, :not_found}
  def find(resource, _store_id \\ @default_id) do
    @table_name
    |> :ets.lookup(resource)
    |> case do
      [{_, normalized_sinks} | _] ->
        {:ok, normalized_sinks}

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
  def handle_call({:put, resource, normalized_sinks}, _from, state) do
    record = {resource, normalized_sinks}
    true = :ets.insert(@table_name, record)
    {:reply, {:ok, record}, state}
  end
end

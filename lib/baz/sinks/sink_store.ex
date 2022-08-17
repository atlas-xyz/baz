defmodule Baz.Sinks.SinkStore do
  use GenServer

  @type store_id :: atom
  @type key :: atom
  @type record :: term

  @default_id :default

  @spec start_link(keyword) :: GenServer.on_start()
  def start_link(args) do
    id = Keyword.get(args, :id, @default_id)
    name = process_name(id)
    GenServer.start_link(__MODULE__, [], name: name)
  end

  @spec process_name(store_id) :: atom
  def process_name(store_id), do: :"#{__MODULE__}_#{store_id}"

  @spec put(record) :: {:ok, {key, record}}
  def put(record, store_id \\ @default_id) do
    store_id
    |> process_name
    |> GenServer.call({:put, record})
  end

  @spec find(key) :: {:ok, record} | {:error, :not_found}
  def find(_key, _store_id \\ @default_id) do
    {:ok, :todo}
  end

  @impl true
  def init(state) do
    table_name = :"sink_store_#{@default_id}"
    :ets.new(table_name, [:set, :protected, :named_table])
    {:ok, state}
  end

  @impl true
  def handle_call({:put, _record}, _from, state) do
    {:reply, :ok, state}
  end
end

defmodule Baz.Sinks.Worker do
  use GenServer
  require Logger

  @spec start_link(term) :: GenServer.on_start()
  def start_link(_) do
    GenServer.start_link(__MODULE__, nil)
  end

  @impl true
  def init(_) do
    {:ok, nil}
  end

  @sink_types ~w[
    collection_packs
    collections
    collection_traits
    collection_assets
    collection_asset_traits
    collection_events
  ]a

  @impl true
  def handle_cast({:write_raw, type, venue, input, api_response}, state)
      when type in @sink_types do
    type
    |> raw_sinks()
    |> Enum.map(fn s ->
      try do
        apply(s, :receive_raw, [type, input, api_response])
      rescue
        e ->
          "could not execute raw sink, venue=~s, type=~w, reason=~s, input=~s, api_response=~s"
          |> format_log_error([venue.name, type, inspect(e), inspect(input), inspect(api_response)])
      end
    end)

    {:noreply, state}
  end

  defp raw_sinks(type) do
    case type do
      :collection_packs -> Baz.RawSinks.get_collection_pack_raw_sinks()
      :collections -> Baz.RawSinks.get_collection_raw_sinks()
      :collection_traits -> Baz.RawSinks.get_collection_trait_raw_sinks()
      :collection_assets -> Baz.RawSinks.get_collection_asset_raw_sinks()
      :collection_asset_traits -> Baz.RawSinks.get_collection_asset_trait_raw_sinks()
      :collection_events -> Baz.RawSinks.get_collection_event_raw_sinks()
    end
  end

  defp format_log_error(format, data) do
    format
    |> :io_lib.format(data)
    |> Logger.error()
  end
end

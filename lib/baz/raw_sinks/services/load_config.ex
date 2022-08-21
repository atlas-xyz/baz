defmodule Baz.RawSinks.Services.LoadConfig do
  alias Baz.RawSinks

  @initial_load_result {0, 0}

  @type load_result :: {load_success :: non_neg_integer, load_error :: non_neg_integer}
  @spec call(map) :: load_result
  def call(sink_config) do
    collection_pack_sinks = get(sink_config, :collection_packs)
    load_result = load(:collection_packs, collection_pack_sinks, @initial_load_result)

    collection_sinks = get(sink_config, :collections)
    load_result = load(:collections, collection_sinks, load_result)

    collection_trait_sinks = get(sink_config, :collection_traits)
    load_result = load(:collection_traits, collection_trait_sinks, load_result)

    collection_asset_sinks = get(sink_config, :collection_assets)
    load_result = load(:collection_assets, collection_asset_sinks, load_result)

    collection_asset_trait_sinks = get(sink_config, :collection_asset_traits)
    load_result = load(:collection_asset_traits, collection_asset_trait_sinks, load_result)

    collection_event_sinks = get(sink_config, :collection_events)
    load_result = load(:collection_events, collection_event_sinks, load_result)

    load_result
  end

  defp get(sink_config, resource) do
    Map.get(sink_config, resource) || []
  end

  defp load(resource, sinks, {load_success, load_error}) do
    case RawSinks.RawSinkStore.put(resource, sinks) do
      {:ok, _} ->
        {load_success + 1, load_error}
        # TODO: wrap ETS error
        # {:error, _} -> {load_success, load_error + 1}
    end
  end
end

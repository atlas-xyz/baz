defmodule Baz.NormalizedSinks do
  alias Baz.NormalizedSinks.Services
  alias Baz.NormalizedSinks.NormalizedSinkStore

  @spec get_collection_pack_normalized_sinks :: [module]
  def get_collection_pack_normalized_sinks do
    {:ok, normalized_sinks} = NormalizedSinkStore.find(:collection_packs)
    normalized_sinks
  end

  @spec get_collection_normalized_sinks :: [module]
  def get_collection_normalized_sinks do
    {:ok, normalized_sinks} = NormalizedSinkStore.find(:collections)
    normalized_sinks
  end

  @spec get_collection_trait_normalized_sinks :: [module]
  def get_collection_trait_normalized_sinks do
    {:ok, normalized_sinks} = NormalizedSinkStore.find(:collection_traits)
    normalized_sinks
  end

  @spec get_collection_asset_normalized_sinks :: [module]
  def get_collection_asset_normalized_sinks do
    {:ok, normalized_sinks} = NormalizedSinkStore.find(:collection_assets)
    normalized_sinks
  end

  @spec get_collection_asset_trait_normalized_sinks :: [module]
  def get_collection_asset_trait_normalized_sinks do
    {:ok, normalized_sinks} = NormalizedSinkStore.find(:collection_asset_traits)
    normalized_sinks
  end

  @spec get_collection_event_normalized_sinks :: [module]
  def get_collection_event_normalized_sinks do
    {:ok, normalized_sinks} = NormalizedSinkStore.find(:collection_events)
    normalized_sinks
  end

  @spec load_config(map) :: Services.LoadConfig.load_result()
  def load_config(sink_config \\ Application.get_env(:baz, :normalized_sinks, %{})) do
    Services.LoadConfig.call(sink_config)
  end
end

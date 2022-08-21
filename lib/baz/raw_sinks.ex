defmodule Baz.RawSinks do
  alias Baz.RawSinks.Services
  alias Baz.RawSinks.RawSinkStore

  @spec get_collection_pack_raw_sinks :: [module]
  def get_collection_pack_raw_sinks do
    {:ok, raw_sinks} = RawSinkStore.find(:collection_packs)
    raw_sinks
  end

  @spec get_collection_raw_sinks :: [module]
  def get_collection_raw_sinks do
    {:ok, raw_sinks} = RawSinkStore.find(:collections)
    raw_sinks
  end

  @spec get_collection_trait_raw_sinks :: [module]
  def get_collection_trait_raw_sinks do
    {:ok, raw_sinks} = RawSinkStore.find(:collection_traits)
    raw_sinks
  end

  @spec get_collection_asset_raw_sinks :: [module]
  def get_collection_asset_raw_sinks do
    {:ok, raw_sinks} = RawSinkStore.find(:collection_assets)
    raw_sinks
  end

  @spec get_collection_asset_trait_raw_sinks :: [module]
  def get_collection_asset_trait_raw_sinks do
    {:ok, raw_sinks} = RawSinkStore.find(:collection_asset_traits)
    raw_sinks
  end

  @spec get_collection_event_raw_sinks :: [module]
  def get_collection_event_raw_sinks do
    {:ok, raw_sinks} = RawSinkStore.find(:collection_events)
    raw_sinks
  end

  @spec load_config(map) :: Services.LoadConfig.load_result()
  def load_config(sink_config \\ Application.get_env(:baz, :raw_sinks, %{})) do
    Services.LoadConfig.call(sink_config)
  end
end

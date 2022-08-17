defmodule Baz.Sinks do
  alias Baz.Venues.Services

  @default_sink Baz.Sinks.Timescale

  @spec get_collection_pack_sinks :: [module]
  def get_collection_pack_sinks do
    [@default_sink]
  end

  @spec get_collection_sinks :: [module]
  def get_collection_sinks do
    [@default_sink]
  end

  @spec get_collection_trait_sinks :: [module]
  def get_collection_trait_sinks do
    [@default_sink]
  end

  @spec get_collection_asset_sinks :: [module]
  def get_collection_asset_sinks do
    [@default_sink]
  end

  @spec get_collection_asset_trait_sinks :: [module]
  def get_collection_asset_trait_sinks do
    [@default_sink]
  end

  @spec get_collection_event_sinks :: [module]
  def get_collection_event_sinks do
    [@default_sink]
  end

  @spec load_config(map) :: Services.LoadConfig.load_result()
  def load_config(sink_config \\ Application.get_env(:baz, :sinks, %{})) do
    Services.LoadConfig.call(sink_config)
  end
end

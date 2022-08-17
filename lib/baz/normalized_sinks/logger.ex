defmodule Baz.NormalizedSinks.Logger do
  require Logger

  @behaviour Baz.CollectionPackSink
  @behaviour Baz.CollectionSink
  @behaviour Baz.CollectionTraitSink
  @behaviour Baz.CollectionAssetSink
  @behaviour Baz.CollectionAssetTraitSink
  @behaviour Baz.CollectionEventSink

  @impl true
  def receive_collection_pack_import(changeset) do
    log_info_inspect(changeset)
  end

  @impl true
  def receive_collection_pack_stream(changeset) do
    log_info_inspect(changeset)
  end

  @impl true
  def receive_collection_import(changeset) do
    log_info_inspect(changeset)
  end

  @impl true
  def receive_collection_stream(changeset) do
    log_info_inspect(changeset)
  end

  @impl true
  def receive_collection_trait_import(changeset) do
    log_info_inspect(changeset)
  end

  @impl true
  def receive_collection_trait_stream(changeset) do
    log_info_inspect(changeset)
  end

  @impl true
  def receive_collection_asset_import(multi) do
    log_info_inspect(multi)
  end

  @impl true
  def receive_collection_asset_stream(changeset) do
    log_info_inspect(changeset)
  end

  @impl true
  def receive_collection_asset_trait_import(changeset) do
    log_info_inspect(changeset)
  end

  @impl true
  def receive_collection_asset_trait_stream(changeset) do
    log_info_inspect(changeset)
  end

  @impl true
  def receive_collection_event_import(multi) do
    log_info_inspect(multi)
  end

  @impl true
  def receive_collection_event_stream(changeset) do
    log_info_inspect(changeset)
  end

  defp log_info_inspect(data) do
    data
    |> inspect()
    |> Logger.info()
  end
end

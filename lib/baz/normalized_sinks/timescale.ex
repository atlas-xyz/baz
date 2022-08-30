defmodule Baz.NormalizedSinks.Timescale do
  alias Baz.Repo

  require Logger

  @behaviour Baz.CollectionPackSink
  @behaviour Baz.CollectionSink
  @behaviour Baz.CollectionTraitSink
  @behaviour Baz.CollectionAssetSink
  @behaviour Baz.CollectionAssetTraitSink
  @behaviour Baz.CollectionEventSink

  @impl true
  def receive_collection_pack_import(changeset) do
    Repo.insert(changeset, on_conflict: :nothing)
  end

  @impl true
  def receive_collection_pack_stream(changeset) do
    Repo.insert(changeset, on_conflict: :nothing)
  end

  @impl true
  def receive_collection_import(changeset) do
    Repo.insert(changeset, on_conflict: :nothing)
  end

  @impl true
  def receive_collection_stream(changeset) do
    Repo.insert(changeset, on_conflict: :nothing)
  end

  @impl true
  def receive_collection_trait_import(changeset) do
    Repo.insert(changeset, on_conflict: :nothing)
  end

  @impl true
  def receive_collection_trait_stream(changeset) do
    Repo.insert(changeset, on_conflict: :nothing)
  end

  @impl true
  def receive_collection_asset_import(multi) do
    Repo.transaction(multi)
  end

  @impl true
  def receive_collection_asset_stream(changeset) do
    Repo.insert(changeset, on_conflict: :nothing)
  end

  @impl true
  def receive_collection_asset_trait_import(changeset) do
    Repo.insert(changeset, on_conflict: :nothing)
  end

  @impl true
  def receive_collection_asset_trait_stream(changeset) do
    Repo.insert(changeset, on_conflict: :nothing)
  end

  @impl true
  def receive_collection_event_import(multi) do
    Logger.info("-> receive_collection_event_IMPORT: #{inspect(multi)}")
    Repo.transaction(multi)
  end

  @impl true
  def receive_collection_event_stream(changeset) do
    Logger.info("->>>> receive_collection_event_STREAM: #{inspect(changeset)}")
    Repo.insert(changeset, on_conflict: :nothing)
  end
end

defmodule Baz.Sinks.Timescale do
  alias Baz.Repo

  @behaviour Baz.CollectionPackSink
  @behaviour Baz.CollectionSink
  @behaviour Baz.CollectionTraitSink
  @behaviour Baz.CollectionAssetSink
  @behaviour Baz.CollectionAssetTraitSink
  @behaviour Baz.CollectionEventSink

  @impl true
  def receive_collection_pack_import(collection_pack_changeset) do
    Repo.insert(collection_pack_changeset, on_conflict: :nothing)
  end

  @impl true
  def receive_collection_pack_stream(collection_pack_changeset) do
    Repo.insert(collection_pack_changeset, on_conflict: :nothing)
  end

  @impl true
  def receive_collection_import(collection_changeset) do
    Repo.insert(collection_changeset, on_conflict: :nothing)
  end

  @impl true
  def receive_collection_stream(collection_changeset) do
    Repo.insert(collection_changeset, on_conflict: :nothing)
  end

  @impl true
  def receive_collection_trait_import(collection_trait_changeset) do
    Repo.insert(collection_trait_changeset, on_conflict: :nothing)
  end

  @impl true
  def receive_collection_trait_stream(collection_trait_changeset) do
    Repo.insert(collection_trait_changeset, on_conflict: :nothing)
  end

  @impl true
  def receive_collection_asset_import(collection_asset_changeset) do
    Repo.insert(collection_asset_changeset, on_conflict: :nothing)
  end

  @impl true
  def receive_collection_asset_stream(collection_asset_changeset) do
    Repo.insert(collection_asset_changeset, on_conflict: :nothing)
  end

  @impl true
  def receive_collection_asset_trait_import(collection_asset_trait_changeset) do
    Repo.insert(collection_asset_trait_changeset, on_conflict: :nothing)
  end

  @impl true
  def receive_collection_asset_trait_stream(collection_asset_trait_changeset) do
    Repo.insert(collection_asset_trait_changeset, on_conflict: :nothing)
  end

  @impl true
  def receive_collection_event_import(collection_event_changeset) do
    Repo.insert(collection_event_changeset, on_conflict: :nothing)
  end

  @impl true
  def receive_collection_event_stream(collection_event_changeset) do
    Repo.insert(collection_event_changeset, on_conflict: :nothing)
  end
end

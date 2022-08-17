defmodule Baz.CollectionAssetSink do
  @callback receive_collection_asset_import(Ecto.Multi.t()) :: term
  @callback receive_collection_asset_stream(Ecto.Changeset.t()) :: term
end

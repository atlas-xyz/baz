defmodule Baz.CollectionAssetTraitSink do
  @callback receive_collection_asset_trait_import(Ecto.Changeset.t()) :: term
  @callback receive_collection_asset_trait_stream(Ecto.Changeset.t()) :: term
end

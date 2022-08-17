defmodule Baz.CollectionTraitSink do
  @callback receive_collection_trait_import(Ecto.Changeset.t()) :: term
  @callback receive_collection_trait_stream(Ecto.Changeset.t()) :: term
end

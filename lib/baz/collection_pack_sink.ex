defmodule Baz.CollectionPackSink do
  @callback receive_collection_pack_import(Ecto.Changeset.t()) :: term
  @callback receive_collection_pack_stream(Ecto.Changeset.t()) :: term
end

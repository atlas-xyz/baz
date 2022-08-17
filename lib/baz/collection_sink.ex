defmodule Baz.CollectionSink do
  @callback receive_collection_import(Ecto.Changeset.t()) :: term
  @callback receive_collection_stream(Ecto.Changeset.t()) :: term
end

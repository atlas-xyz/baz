defmodule Baz.CollectionEventSink do
  @callback receive_collection_event_import(Ecto.Changeset.t()) :: term
  @callback receive_collection_event_stream(Ecto.Changeset.t()) :: term
end

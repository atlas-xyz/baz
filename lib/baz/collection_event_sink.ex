defmodule Baz.CollectionEventSink do
  @callback receive_collection_event_import(Ecto.Multi.t()) :: term
  @callback receive_collection_event_stream(Ecto.Changeset.t()) :: term
end

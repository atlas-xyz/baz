defmodule Baz.TestSupport.Factories.CollectionEventFactory do
  alias Baz.Repo
  alias Baz.CollectionEvents

  @type collection_event :: CollectionEvents.CollectionEvent.t()

  @spec create_collection_event(map) :: {:ok, collection_event} | {:error, Ecto.Changeset.t()}
  def create_collection_event(attrs) do
    %CollectionEvents.CollectionEvent{}
    |> CollectionEvents.CollectionEvent.changeset(attrs)
    |> Repo.insert()
  end
end

defmodule Baz.CollectionEvents.Queries.FilterAndOrder do
  alias Baz.CollectionEvents
  import Ecto.Query, warn: false

  def new(_opts) do
    from(CollectionEvents.CollectionEvent)
  end
end

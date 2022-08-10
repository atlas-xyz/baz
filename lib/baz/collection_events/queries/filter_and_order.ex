defmodule Baz.CollectionEvents.Queries.FilterAndOrder do
  alias Baz.CollectionEvents
  import Ecto.Query, warn: false

  @type where_opt :: {:where, [{atom, term}]}
  @type order_opt :: {:order, [atom]}
  @type opts :: [where_opt | order_opt]

  @spec new(opts) :: Ecto.Query.t()
  def new(_opts) do
    from(CollectionEvents.CollectionEvent)
  end
end

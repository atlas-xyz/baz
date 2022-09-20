defmodule Baz.Collections.Queries.Search do
  alias Baz.Collections
  import Ecto.Query, warn: false

  @type search_query :: String.t()

  @spec new(search_query) :: Ecto.Queryable.t()
  def new(search_query) do
    Collections.Collection
    |> where(
      [c],
      ilike(c.name, ^"%#{search_query}%") or
        ilike(c.slug, ^"%#{search_query}%") or
        ilike(c.venue, ^"%#{search_query}%")
    )
    |> order_by(asc: :name)
  end
end

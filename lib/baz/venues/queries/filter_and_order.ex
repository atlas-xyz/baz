defmodule Baz.Venues.Queries.FilterAndOrder do
  alias Baz.Venues
  import Ecto.Query, warn: false

  def new(opts) do
    from(Venues.Venue)
  end
end

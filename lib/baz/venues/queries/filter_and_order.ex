defmodule Baz.Venues.Queries.FilterAndOrder do
  alias Baz.Venues
  import Ecto.Query, warn: false

  def new(_opts) do
    from(Venues.Venue)
  end
end

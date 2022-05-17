defmodule Baz.Collections.Queries.FilterAndOrder do
  alias Baz.Collections
  import Ecto.Query, warn: false

  def new(opts) do
    from(Collections.Collection)
  end
end

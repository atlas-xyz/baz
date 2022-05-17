defmodule Baz.Collections.Queries.FilterAndOrder do
  alias Baz.Collections
  import Ecto.Query, warn: false

  def new(_opts) do
    from(Collections.Collection)
  end
end

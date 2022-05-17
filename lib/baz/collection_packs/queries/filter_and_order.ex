defmodule Baz.CollectionPacks.Queries.FilterAndOrder do
  alias Baz.CollectionPacks
  import Ecto.Query, warn: false

  def new(opts) do
    from(CollectionPacks.CollectionPack)
  end
end

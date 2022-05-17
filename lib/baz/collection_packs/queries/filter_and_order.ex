defmodule Baz.CollectionPacks.Queries.FilterAndOrder do
  alias Baz.CollectionPacks
  import Ecto.Query, warn: false

  def new(_opts) do
    from(CollectionPacks.CollectionPack)
  end
end

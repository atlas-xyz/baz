defmodule Baz.CollectionImports.Queries.FilterAndOrder do
  alias Baz.CollectionImports
  import Ecto.Query, warn: false

  def new(opts) do
    from(CollectionImports.CollectionImport)
  end
end

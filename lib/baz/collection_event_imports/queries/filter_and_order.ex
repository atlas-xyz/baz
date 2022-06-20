defmodule Baz.CollectionEventImports.Queries.FilterAndOrder do
  alias Baz.CollectionEventImports
  import Ecto.Query, warn: false

  def new(_opts) do
    from(CollectionEventImports.CollectionEventImport)
  end
end

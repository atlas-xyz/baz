defmodule Baz.CollectionAssetImports.Queries.FilterAndOrder do
  alias Baz.CollectionAssetImports
  import Ecto.Query, warn: false

  def new(_opts) do
    from(CollectionAssetImports.CollectionAssetImport)
  end
end

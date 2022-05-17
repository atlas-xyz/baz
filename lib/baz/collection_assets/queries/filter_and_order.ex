defmodule Baz.CollectionAssets.Queries.FilterAndOrder do
  alias Baz.CollectionAssets
  import Ecto.Query, warn: false

  def new(_opts) do
    from(CollectionAssets.CollectionAsset)
  end
end

defmodule Baz.CollectionAssetTraits.Queries.FilterAndOrder do
  alias Baz.CollectionAssetTraits
  import Ecto.Query, warn: false

  def new(_opts) do
    from(CollectionAssetTraits.CollectionAssetTrait)
  end
end

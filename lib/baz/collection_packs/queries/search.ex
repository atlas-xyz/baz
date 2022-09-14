defmodule Baz.CollectionPacks.Queries.Search do
  alias Baz.CollectionPacks
  import Ecto.Query, warn: false

  @type query :: String.t() | nil
  @type opts :: [{:page, pos_integer} | {:page_size, pos_integer}]

  @spec new(query, opts) :: Ecto.Queryable.t()
  def new(search_query, _opts) do
    from(CollectionPacks.CollectionPack)
  end
end

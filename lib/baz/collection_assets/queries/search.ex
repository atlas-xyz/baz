defmodule Baz.CollectionAssets.Queries.Search do
  alias Baz.CollectionAssets
  import Ecto.Query, warn: false

  @type search_query :: String.t()
  @type where_opt :: {:where, keyword}
  @type order_by_opt :: {:order_by, keyword}
  @type opts :: [where_opt]

  @default_order_by [asc: :name]

  @spec new(search_query, opts) :: Ecto.Queryable.t()
  def new(search_query, opts) do
    queryable =
      case Keyword.get(opts, :where) do
        nil -> from(CollectionAssets.CollectionAsset)
        filter -> from(CollectionAssets.CollectionAsset, where: filter)
      end

    queryable
    |> where(
      [c],
      ilike(c.name, ^"%#{search_query}%") or
        ilike(c.slug, ^"%#{search_query}%") or
        ilike(c.venue, ^"%#{search_query}%") or
        ilike(c.token_id, ^"%#{search_query}%")
    )
    |> order_by(@default_order_by)
  end
end

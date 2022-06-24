defmodule Baz.CollectionAssetTraits do
  alias Baz.Repo
  alias Baz.CollectionAssetTraits.CollectionAssetTrait
  alias Baz.CollectionAssetTraits.Queries

  @type where_opt :: {:where, [{atom, term}]}
  @type order_opt :: {:order, [atom]}
  @type collection_asset_trait :: CollectionAssetTrait.t()

  @type filter_and_order_opts :: [where_opt | order_opt]
  @spec filter_and_order(filter_and_order_opts) :: [collection_asset_trait]
  def filter_and_order(opts) do
    opts
    |> Queries.FilterAndOrder.new()
    |> Repo.all()
  end
end

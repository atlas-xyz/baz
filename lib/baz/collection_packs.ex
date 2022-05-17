defmodule Baz.CollectionPacks do
  alias Baz.CollectionPacks
  alias Baz.Repo

  @type where_opt :: {:where, [{atom, term}]}
  @type order_opt :: {:order, [atom]}

  @type filter_and_order_opts :: [where_opt | order_opt]
  # @spec filter_and_order(filter_and_order_opts) :: [CollectionPacks.CollectionPack.t()]
  @spec filter_and_order(filter_and_order_opts) :: [term]
  def filter_and_order(opts) do
    opts
    |> CollectionPacks.Queries.FilterAndOrder.new()
    |> Repo.all()
  end
end

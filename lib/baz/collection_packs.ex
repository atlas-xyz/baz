defmodule Baz.CollectionPacks do
  @type where_opt :: {:where, [{atom, term}]}
  @type order_opt :: {:order, [atom]}

  @type filter_and_order_opts :: [where_opt | order_opt]
  @spec filter_and_order(filter_and_order_opts) :: [Collections.CollectionPacks.t()]
  def filter_and_order(_opts) do
    []
  end
end

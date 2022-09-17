defmodule Baz.VenueWebSockets.Queries.FilterAndOrder do
  alias Baz.VenueWebSockets
  import Ecto.Query, warn: false

  @type where_opt :: {:where, [{atom, term}]}
  @type order_opt :: {:order, [atom]}
  @type opts :: [where_opt | order_opt]

  @spec new(opts) :: Ecto.Query.t()
  def new(opts) do
    VenueWebSockets.VenueWebSocket
    |> from()
    |> apply_where(opts)
    |> apply_order(opts)
  end

  defp apply_where(query, opts) do
    clause = Keyword.get(opts, :where)

    if clause != nil do
      where(query, ^clause)
    else
      query
    end
  end

  defp apply_order(query, opts) do
    clause = Keyword.get(opts, :order)

    if clause != nil do
      order_by(query, ^clause)
    else
      query
    end
  end
end

defmodule Baz.VenueChannels do
  alias __MODULE__

  @type where_opt :: {:where, [{atom, term}]}
  @type order_opt :: {:order, [atom]}

  @type filter_and_order_opts :: [where_opt | order_opt]
  @spec filter_and_order(filter_and_order_opts) :: [VenueChannels.VenueChannel.t()]
  def filter_and_order(_opts) do
    []
  end

  @type start_opts :: [where_opt]
  @spec start(start_opts) :: {started :: non_neg_integer, already_started :: non_neg_integer}
  def start(_opts) do
    {0, 0}
  end

  @type stop_opts :: [where_opt]
  @spec stop(stop_opts) :: {stopped :: non_neg_integer, already_stopped :: non_neg_integer}
  def stop(_opts) do
    {0, 0}
  end
end

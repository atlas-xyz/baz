defmodule Baz.Venues do
  alias __MODULE__

  @type where_opt :: {:where, [{atom, term}]}
  @type order_opt :: {:order, [atom]}

  @type filter_and_order_opts :: [where_opt | order_opt]
  @spec filter_and_order_venue_instances(filter_and_order_opts) :: [Venues.VenueInstance.t()]
  def filter_and_order_venue_instances(_opts) do
    []
  end

  @type start_opts :: [where_opt]
  @spec start_venues(start_opts) :: {started :: non_neg_integer, already_started :: non_neg_integer}
  def start_venues(_opts) do
    {0, 0}
  end

  @type stop_opts :: [where_opt]
  @spec stop_venues(start_opts) :: {stopped :: non_neg_integer, already_stopped :: non_neg_integer}
  def stop_venues(_opts) do
    {0, 0}
  end
end

defmodule Baz.IEx.Commands.SubscribeVenueWebSocket do
  @moduledoc """
  Subscribe to a web socket for the venue
  """

  @type venue_name :: Baz.Venues.Venue.name()
  @type slugs :: String.t()
  @type opts :: [{:venue, venue_name} | {:slugs, slugs}]

  @spec subscribe_venue_web_socket(opts) :: no_return
  def subscribe_venue_web_socket(opts) do
    venue_name = Keyword.fetch!(opts, :venue)
    slug_mask = Keyword.fetch!(opts, :slugs)

    Baz.VenueWebSockets.subscribe_venue_web_socket(venue_name, slug_mask)
  end
end

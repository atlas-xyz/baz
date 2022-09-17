defmodule Baz.IEx.Commands.StartVenueWebSocket do
  @moduledoc """
  Start a web socket for the venue
  """

  @type venue_name :: Baz.Venues.Venue.name()
  @type opts :: [{:venue, venue_name}]

  @spec start_venue_web_socket(opts) :: no_return
  def start_venue_web_socket(opts) do
    venue_name = Keyword.fetch!(opts, :venue)
    Baz.VenueWebSockets.start_venue_web_socket(venue_name)
  end
end

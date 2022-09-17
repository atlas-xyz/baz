defmodule Baz.IEx.Commands.StopVenueWebSocket do
  @moduledoc """
  Stop a web socket for the venue
  """

  @type venue_name :: Baz.Venues.Venue.name()
  @type opts :: [{:venue, venue_name}]

  @spec stop_venue_web_socket(opts) :: no_return
  def stop_venue_web_socket(opts) do
    venue_name = Keyword.fetch!(opts, :venue)

    Baz.VenueWebSockets.stop_venue_web_socket(venue_name)
  end
end

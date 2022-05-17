defmodule Baz.IEx.Commands.StartVenueChannels do
  @moduledoc """
  Start venue channels matching the `where` filter
  """

  @type opts :: Baz.VenueChannels.start_opts()

  @spec start(opts) :: no_return
  def start(opts) do
    {started, already_started} = Baz.VenueChannels.start(opts)
    IO.puts("started venue channels new=#{started}, already_running=#{already_started}")
    IEx.dont_display_result()
  end
end

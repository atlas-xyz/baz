defmodule Baz.IEx.Commands.StopVenueChannels do
  @moduledoc """
  Stop venue channels matching the `where` filter
  """

  @type opts :: Baz.VenueChannels.stop_opts()

  @spec stop(opts) :: no_return
  def stop(opts) do
    {stopped, already_stopped} = Baz.VenueChannels.stop(opts)
    IO.puts("stopped venue channels new=#{stopped}, already_stopped=#{already_stopped}")
    IEx.dont_display_result()
  end
end

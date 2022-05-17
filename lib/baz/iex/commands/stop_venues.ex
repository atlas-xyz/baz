defmodule Baz.IEx.Commands.StopVenues do
  @moduledoc """
  Stop venues matching the `where` filter
  """

  @type opts :: Baz.Venues.stop_opts()

  @spec stop(opts) :: no_return
  def stop(opts) do
    {stopped, already_stopped} = Baz.Venues.stop_venues(opts)
    IO.puts("stopped venues new=#{stopped}, already_stopped=#{already_stopped}")
    IEx.dont_display_result()
  end
end

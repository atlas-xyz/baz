defmodule Baz.IEx.Commands.StartVenues do
  @moduledoc """
  Start venues matching the `where` filter
  """

  @type opts :: Baz.Venues.start_opts()

  @spec start(opts) :: no_return
  def start(opts) do
    {started, already_started} = Baz.Venues.start_venues(opts)
    IO.puts("started venues new=#{started}, already_running=#{already_started}")
    IEx.dont_display_result()
  end
end

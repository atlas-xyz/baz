defmodule Baz.IEx.Commands.VenueWebSockets do
  @moduledoc """
  Render a table of filtered and sorted collection assets
  """

  import Baz.IEx.Output.Table, only: [render!: 2]

  @type opts :: Baz.VenueWebSockets.filter_and_order_opts()

  @header [
    "Venue",
    "PID",
  ]

  @spec filter_and_order(opts) :: no_return
  def filter_and_order(opts) do
    opts
    |> Baz.VenueWebSockets.filter_and_order()
    |> format_rows()
    |> render!(@header)
  end

  defp format_rows(venue_web_sockets) do
    venue_web_sockets
    |> Enum.map(fn e ->
      [
        e.venue,
        e.pid
      ]
      |> Enum.map(&format_col/1)
    end)
  end

  defp format_col(nil), do: "-"
  defp format_col([]), do: "-"
  defp format_col(val) when is_list(val), do: val |> Enum.join(", ")
  defp format_col(val) when is_pid(val), do: val |> inspect()
  defp format_col(val), do: val
end

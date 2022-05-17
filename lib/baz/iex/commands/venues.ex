defmodule Baz.IEx.Commands.Venues do
  @moduledoc """
  Render a table of filtered and sorted venues
  """

  import Baz.IEx.Output.Table, only: [render!: 2]

  @type opts :: Baz.Venues.filter_and_order_opts()

  @header [
    "Name",
    "Collections",
    "Credentials",
    "Poll Stream Enabled",
    "WebSocket Stream Enabled",
    "Start On Boot"
  ]

  @spec filter_and_order(opts) :: no_return
  def filter_and_order(opts) do
    opts
    |> Baz.Venues.filter_and_order()
    |> format_rows()
    |> render!(@header)
  end

  defp format_rows(instances) do
    instances
    |> Enum.map(fn i ->
      [
        i.name,
        i.collections,
        i.credentials,
        i.poll_stream_enabled,
        i.websocket_stream_enabled,
        i.start_on_boot
      ]
      |> Enum.map(&format_col/1)
    end)
  end

  defp format_col(nil), do: "-"
  defp format_col([]), do: "-"
  defp format_col(val) when is_list(val), do: val |> Enum.join(", ")
  defp format_col(val) when is_map(val), do: val |> Map.keys()
  defp format_col(val), do: val
end

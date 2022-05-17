defmodule Baz.IEx.Commands.Collections do
  @moduledoc """
  Render a table of filtered and sorted venues
  """

  import Baz.IEx.Output.Table, only: [render!: 2]

  @type opts :: Baz.Collections.filter_and_order_opts()

  @header [
    # "ID",
    # "Credentials",
    # "Status",
    # "Streams",
    # "Timeout",
    # "Start On Boot"
  ]

  @spec filter_and_order(opts) :: no_return
  def filter_and_order(opts) do
    opts
    |> Baz.Collections.filter_and_order()
    |> format_rows()
    |> render!(@header)
  end

  defp format_rows(instances) do
    instances
    |> Enum.map(fn i ->
      [
        # i.id,
        # i.credentials |> Map.keys(),
        # i.status,
        # i.streams,
        # i.timeout,
        # i.start_on_boot
      ]
      |> Enum.map(&format_col/1)
    end)
  end

  defp format_col(nil), do: "-"
  defp format_col([]), do: "-"
  defp format_col(val) when is_list(val), do: val |> Enum.join(", ")
  defp format_col(val), do: val
end

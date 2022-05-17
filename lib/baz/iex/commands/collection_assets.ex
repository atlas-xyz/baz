defmodule Baz.IEx.Commands.CollectionAssets do
  @moduledoc """
  Render a table of filtered and sorted collection assets
  """

  import Baz.IEx.Output.Table, only: [render!: 2]

  @type opts :: Baz.CollectionAssets.filter_and_order_opts()

  @header [
    "ID",
    "Venue",
    "Slug",
    "Token ID",
    "Name"
  ]

  @spec filter_and_order(opts) :: no_return
  def filter_and_order(opts) do
    opts
    |> Baz.CollectionAssets.filter_and_order()
    |> format_rows()
    |> render!(@header)
  end

  defp format_rows(collections) do
    collections
    |> Enum.map(fn c ->
      [
        c.id,
        c.venue,
        c.slug,
        c.token_id,
        c.name
      ]
      |> Enum.map(&format_col/1)
    end)
  end

  defp format_col(nil), do: "-"
  defp format_col([]), do: "-"
  defp format_col(val) when is_list(val), do: val |> Enum.join(", ")
  defp format_col(val), do: val
end

defmodule Baz.IEx.Commands.Collections do
  @moduledoc """
  Render a table of filtered and sorted collections
  """

  import Baz.IEx.Output.Table, only: [render!: 2]

  @type opts :: Baz.Collections.filter_and_order_opts()

  @header [
    "ID",
    "Venue",
    "Slug",
    "Name",
    "Description",
    "Image URI",
    "Banner Image URI"
  ]

  @spec filter_and_order(opts) :: no_return
  def filter_and_order(opts) do
    opts
    |> Baz.Collections.filter_and_order()
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
        c.name,
        truncate(c.description, 10),
        truncate(c.image_uri, 10),
        truncate(c.banner_image_uri, 10)
      ]
      |> Enum.map(&format_col/1)
    end)
  end

  defp truncate(str, length) do
    cond do
      str == nil ->
        nil

      String.length(str) > length ->
        "#{String.slice(str, 0, length)}..."

      true ->
        str
    end
  end

  defp format_col(nil), do: "-"
  defp format_col([]), do: "-"
  defp format_col(val) when is_list(val), do: val |> Enum.join(", ")
  defp format_col(val), do: val
end

defmodule Baz.IEx.Commands.CollectionPacks do
  @moduledoc """
  Render a table of filtered and sorted collection packs
  """

  import Baz.IEx.Output.Table, only: [render!: 2]

  @type opts :: Baz.CollectionPacks.filter_and_order_opts()

  @header [
    "ID",
    "Slug",
    "Name",
    "Verified",
    "Visible",
    "Description",
    "Image URI",
    "Banner Image URI"
  ]

  @spec filter_and_order(opts) :: no_return
  def filter_and_order(opts) do
    opts
    |> Baz.CollectionPacks.filter_and_order()
    |> format_rows()
    |> render!(@header)
  end

  defp format_rows(collection_packs) do
    collection_packs
    |> Enum.map(fn p ->
      [
        p.id,
        p.slug,
        p.name,
        p.is_verified,
        p.is_visible,
        truncate(p.description, 10),
        truncate(p.image_uri, 10),
        truncate(p.banner_image_uri, 10)
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

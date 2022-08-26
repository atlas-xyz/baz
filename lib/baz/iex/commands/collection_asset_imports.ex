defmodule Baz.IEx.Commands.CollectionAssetImports do
  @moduledoc """
  Render a table of filtered and sorted collection imports
  """

  import Baz.IEx.Output.Table, only: [render!: 2]

  @type opts :: Baz.CollectionAssetImports.filter_and_order_opts()

  @header [
    "ID",
    "Venue",
    "Slug",
    "Token IDs",
    "Max Retries",
    "Status",
    "Last Updated"
  ]

  @spec filter_and_order(opts) :: no_return
  def filter_and_order(opts) do
    opts
    |> Baz.CollectionAssetImports.filter_and_order()
    |> format_rows()
    |> render!(@header)
  end

  defp format_rows(backfills) do
    backfills
    |> Enum.map(fn b ->
      [
        b.id,
        b.venue,
        b.slug,
        b.token_ids,
        b.max_retries,
        b.status,
        b.updated_at
      ]
      |> Enum.map(&format_col/1)
    end)
  end

  defp format_col(nil), do: "-"
  defp format_col([]), do: "-"
  defp format_col(val) when is_list(val), do: val |> Enum.join(", ")
  defp format_col(val), do: val
end

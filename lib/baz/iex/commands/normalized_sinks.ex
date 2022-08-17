defmodule Baz.IEx.Commands.NormalizedSinks do
  @moduledoc """
  Render a table of filtered and sorted collection packs
  """

  import Baz.IEx.Output.Table, only: [render!: 2]

  defmodule Row do
    defstruct ~w[resource sinks]a
  end

  #@type opts :: Baz.NormalizedSinks.filter_and_order_opts()
  @type opts :: []

  @header [
    "Resource",
    "Sinks"
  ]

  @spec filter_and_order(opts) :: no_return
  def filter_and_order(opts) do
    opts
    |> build_rows()
    |> format_rows()
    |> render!(@header)
  end

  def build_rows(_opts) do
    collection_pack_sinks = Baz.NormalizedSinks.get_collection_pack_normalized_sinks()
    collection_sinks = Baz.NormalizedSinks.get_collection_normalized_sinks()
    collection_trait_sinks = Baz.NormalizedSinks.get_collection_trait_normalized_sinks()
    collection_asset_sinks = Baz.NormalizedSinks.get_collection_asset_normalized_sinks()
    collection_asset_trait_sinks = Baz.NormalizedSinks.get_collection_asset_trait_normalized_sinks()
    collection_event_sinks = Baz.NormalizedSinks.get_collection_event_normalized_sinks()

    [
      %Row{resource: :collection_packs, sinks: collection_pack_sinks},
      %Row{resource: :collections, sinks: collection_sinks},
      %Row{resource: :collection_traits, sinks: collection_trait_sinks},
      %Row{resource: :collection_assets, sinks: collection_asset_sinks},
      %Row{resource: :collection_asset_traits, sinks: collection_asset_trait_sinks},
      %Row{resource: :collection_events, sinks: collection_event_sinks},
    ]
  end

  defp format_rows(normalized_sinks) do
    normalized_sinks
    |> Enum.map(fn p ->
      [
        p.resource,
        p.sinks,
      ]
      |> Enum.map(&format_col/1)
    end)
  end

  defp format_col(nil), do: "-"
  defp format_col([]), do: "-"
  defp format_col(val) when is_list(val), do: val |> Enum.join(", ")
  defp format_col(val), do: val
end

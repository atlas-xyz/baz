defmodule Baz.CollectionAssets.FilterAndOrderTest do
  use Baz.TestSupport.DataCase, async: false

  test ".filter_and_order/1 can filter by attributes" do
    {:ok, open_sea_azuki_1} =
      create_collection_asset(%{
        venue: "open_sea",
        slug: "azuki",
        token_id: 1,
        name: "Azuki #1"
      })

    {:ok, x2y2_azuki_1} =
      create_collection_asset(%{
        venue: "x2y2",
        slug: "azuki",
        token_id: 1,
        name: "Azuki #1"
      })

    {:ok, open_sea_doodles_1} =
      create_collection_asset(%{
        venue: "open_sea",
        slug: "doodles-official",
        token_id: 1,
        name: "Doodles #1"
      })

    open_sea_assets = Baz.CollectionAssets.filter_and_order(where: [venue: "open_sea"])
    assert length(open_sea_assets) == 2
    assert Enum.member?(open_sea_assets, open_sea_azuki_1) == true
    assert Enum.member?(open_sea_assets, open_sea_doodles_1) == true

    x2y2_assets = Baz.CollectionAssets.filter_and_order(where: [venue: "x2y2"])
    assert length(x2y2_assets) == 1
    assert Enum.member?(x2y2_assets, x2y2_azuki_1) == true

    open_sea_azukis =
      Baz.CollectionAssets.filter_and_order(where: [venue: "open_sea", slug: "azuki"])

    assert length(open_sea_azukis) == 1
    assert Enum.member?(open_sea_azukis, open_sea_azuki_1) == true
  end

  test ".filter_and_order/1 can order by attributes" do
    {:ok, open_sea_azuki} =
      create_collection_asset(%{
        venue: "open_sea",
        slug: "azuki",
        token_id: 1,
        name: "Azuki #1"
      })

    {:ok, x2y2_doodles} =
      create_collection_asset(%{
        venue: "x2y2",
        slug: "doodles-official",
        token_id: 1,
        name: "Doodles #1"
      })

    default_order = Baz.CollectionAssets.filter_and_order(order: [:venue])
    assert length(default_order) == 2
    assert Enum.at(default_order, 0) == open_sea_azuki
    assert Enum.at(default_order, 1) == x2y2_doodles

    desc_order = Baz.CollectionAssets.filter_and_order(order: [desc: :venue])
    assert length(desc_order) == 2
    assert Enum.at(desc_order, 0) == x2y2_doodles
    assert Enum.at(desc_order, 1) == open_sea_azuki
  end
end

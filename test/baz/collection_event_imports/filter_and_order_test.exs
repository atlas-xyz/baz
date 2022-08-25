defmodule Baz.CollectionEventImports.FilterAndOrderTest do
  use Baz.TestSupport.DataCase, async: false

  @after_seconds 60 * 60

  test ".filter_and_order/1 can filter by attributes" do
    {:ok, open_sea_azuki_1} =
      create_collection_event_import(%{
        venue: "open_sea",
        slug: "azuki",
        token_id: 1,
        event_type: "item_listed",
        after: DateTime.utc_now() |> DateTime.add(-@after_seconds, :second),
        before: DateTime.utc_now(),
        status: "available",
        max_retries: 3
      })

    {:ok, x2y2_azuki_1} =
      create_collection_event_import(%{
        venue: "x2y2",
        slug: "azuki",
        token_id: 1,
        event_type: "item_listed",
        after: DateTime.utc_now() |> DateTime.add(-@after_seconds, :second),
        before: DateTime.utc_now(),
        status: "available",
        max_retries: 3
      })

    {:ok, open_sea_doodles_1} =
      create_collection_event_import(%{
        venue: "open_sea",
        slug: "doodles-official",
        token_id: 1,
        event_type: "item_listed",
        after: DateTime.utc_now() |> DateTime.add(-@after_seconds, :second),
        before: DateTime.utc_now(),
        status: "available",
        max_retries: 3
      })

    open_sea_event_imports =
      Baz.CollectionEventImports.filter_and_order(where: [venue: "open_sea"])

    assert length(open_sea_event_imports) == 2
    assert Enum.member?(open_sea_event_imports, open_sea_azuki_1) == true
    assert Enum.member?(open_sea_event_imports, open_sea_doodles_1) == true

    x2y2_event_imports = Baz.CollectionEventImports.filter_and_order(where: [venue: "x2y2"])
    assert length(x2y2_event_imports) == 1
    assert Enum.member?(x2y2_event_imports, x2y2_azuki_1) == true

    open_sea_azukis =
      Baz.CollectionEventImports.filter_and_order(where: [venue: "open_sea", slug: "azuki"])

    assert length(open_sea_azukis) == 1
    assert Enum.member?(open_sea_azukis, open_sea_azuki_1) == true
  end
end

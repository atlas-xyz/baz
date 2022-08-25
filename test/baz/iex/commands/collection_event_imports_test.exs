defmodule Baz.IEx.Commands.CollectionEventImportsTest do
  use Baz.TestSupport.DataCase, async: false
  import ExUnit.CaptureIO

  test "shows each collection event import" do
    create_collection_event_import(%{
      venue: "open_sea",
      slug: "azuki",
      token_ids: [1, 2, 3],
      event_types: ["item_listed", "item_sold"],
      before: ~U[2022-01-20 12:00:05.123456Z],
      after: ~U[2022-01-01 12:00:05.123456Z],
      max_retries: 3,
      status: "active"
    })

    assert capture_io(&Baz.IEx.collection_event_imports/0) == """
           +----------+-------+-----------------------------+-----------------------------+-----------+------------------------+--------+
           | Venue    | Slug  | Before                      | After                       | Token IDs | Types                  | Status |
           +----------+-------+-----------------------------+-----------------------------+-----------+------------------------+--------+
           | open_sea | azuki | 2022-01-20 12:00:05.123456Z | 2022-01-01 12:00:05.123456Z | 1, 2, 3   | item_listed, item_sold | active |
           +----------+-------+-----------------------------+-----------------------------+-----------+------------------------+--------+\n
           """
  end

  test "shows an empty table when there are no event imports" do
    assert capture_io(&Baz.IEx.collection_event_imports/0) == """
           +-------+------+--------+-------+-----------+-------+--------+
           | Venue | Slug | Before | After | Token IDs | Types | Status |
           +-------+------+--------+-------+-----------+-------+--------+
           | -     | -    | -      | -     | -         | -     | -      |
           +-------+------+--------+-------+-----------+-------+--------+\n
           """
  end
end

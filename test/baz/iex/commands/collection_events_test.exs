defmodule Baz.IEx.Commands.EventsTest do
  use Baz.TestSupport.DataCase, async: false
  import ExUnit.CaptureIO

  test "shows each local collection event" do
    create_collection_event(%{
      venue: "open_sea",
      slug: "azuki",
      token_id: 1,
      id: "123456789",
      event_type: "item_sold",
      event_timestamp: ~U[2022-01-20 12:00:05.123456Z]
    })

    assert capture_io(&Baz.IEx.collection_events/0) == """
           +-----------------------------+----------+-------+----------+-----------+
           | Timestamp                   | Venue    | Slug  | Token ID | Type      |
           +-----------------------------+----------+-------+----------+-----------+
           | 2022-01-20 12:00:05.123456Z | open_sea | azuki | 1        | item_sold |
           +-----------------------------+----------+-------+----------+-----------+\n
           """
  end

  test "shows an empty table when there are no collection_events" do
    assert capture_io(&Baz.IEx.collection_events/0) == """
           +-----------+-------+------+----------+------+
           | Timestamp | Venue | Slug | Token ID | Type |
           +-----------+-------+------+----------+------+
           | -         | -     | -    | -        | -    |
           +-----------+-------+------+----------+------+\n
           """
  end
end

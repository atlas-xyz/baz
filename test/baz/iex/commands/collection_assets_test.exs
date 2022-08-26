defmodule Baz.IEx.Commands.CollectionAssetsTest do
  use Baz.TestSupport.DataCase, async: false
  import ExUnit.CaptureIO

  test "shows each local collection assets" do
    create_collection_asset(%{
      venue: "open_sea",
      slug: "azuki",
      token_id: "1",
      name: "Azuki #1"
    })

    create_collection_asset(%{
      venue: "open_sea",
      slug: "doodles-official",
      token_id: "20",
      name: "Doodles #20"
    })

    assert capture_io(&Baz.IEx.collection_assets/0) == """
           +----------+------------------+----------+-------------+
           | Venue    | Slug             | Token ID | Name        |
           +----------+------------------+----------+-------------+
           | open_sea | azuki            | 1        | Azuki #1    |
           | open_sea | doodles-official | 20       | Doodles #20 |
           +----------+------------------+----------+-------------+\n
           """
  end

  test "shows an empty table when there are no collection assets" do
    assert capture_io(&Baz.IEx.collection_assets/0) == """
           +-------+------+----------+------+
           | Venue | Slug | Token ID | Name |
           +-------+------+----------+------+
           | -     | -    | -        | -    |
           +-------+------+----------+------+\n
           """
  end
end

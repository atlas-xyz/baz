defmodule Baz.IEx.Commands.CollectionsTest do
  use Baz.TestSupport.DataCase, async: false
  import ExUnit.CaptureIO

  test "shows each local collection" do
    create_collection(%{venue: "open_sea", slug: "azuki", name: "Azuki"})
    create_collection(%{venue: "open_sea", slug: "doodles-official", name: "Doodles"})

    assert capture_io(&Baz.IEx.collections/0) == """
           +----------+------------------+---------+-------------+-----------+------------------+
           | Venue    | Slug             | Name    | Description | Image URI | Banner Image URI |
           +----------+------------------+---------+-------------+-----------+------------------+
           | open_sea | azuki            | Azuki   | -           | -         | -                |
           | open_sea | doodles-official | Doodles | -           | -         | -                |
           +----------+------------------+---------+-------------+-----------+------------------+\n
           """
  end

  test "shows an empty table when there are no collections" do
    assert capture_io(&Baz.IEx.collections/0) == """
           +-------+------+------+-------------+-----------+------------------+
           | Venue | Slug | Name | Description | Image URI | Banner Image URI |
           +-------+------+------+-------------+-----------+------------------+
           | -     | -    | -    | -           | -         | -                |
           +-------+------+------+-------------+-----------+------------------+\n
           """
  end
end

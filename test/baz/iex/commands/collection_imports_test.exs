defmodule Baz.IEx.Commands.CollectionImportsTest do
  use Baz.TestSupport.DataCase, async: false
  import ExUnit.CaptureIO

  test "shows each local collection import" do
    create_collection_import(%{
      venue: "open_sea",
      slug: "azuki",
      token_id: 1,
      name: "Azuki #1",
      max_retries: 3,
      status: "available",
      last_updated_at: ~U[2020-05-18 21:25:06.098765Z]
    })

    create_collection_import(%{
      venue: "open_sea",
      slug: "doodles-official",
      token_id: 20,
      name: "Doodles #20",
      max_retries: 3,
      status: "completed",
      last_updated_at: ~U[2019-05-18 21:25:06.098765Z]
    })

    output = capture_io(&Baz.IEx.collection_imports/0)

    assert String.match?(
             output,
             ~r/[a-z0-9]{8,8}-[a-z0-9]{4,4}-[a-z0-9]{4,4}-[a-z0-9]{4,4}-[a-z0-9]{12,12}\s+\| open_sea \| azuki\s+\| available \|/
           ) == true

    assert String.match?(
             output,
             ~r/[a-z0-9]{8,8}-[a-z0-9]{4,4}-[a-z0-9]{4,4}-[a-z0-9]{4,4}-[a-z0-9]{12,12}\s+\| open_sea \| doodles-official\s+\| completed \|/
           ) == true
  end

  test "shows an empty table when there are no collection imports" do
    assert capture_io(&Baz.IEx.collection_imports/0) == """
           +----+-------+------+--------+--------------+
           | ID | Venue | Slug | Status | Last Updated |
           +----+-------+------+--------+--------------+
           | -  | -     | -    | -      | -            |
           +----+-------+------+--------+--------------+\n
           """
  end
end

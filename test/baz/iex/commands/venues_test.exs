defmodule Baz.IEx.Commands.VenuesTest do
  use Baz.TestSupport.DataCase, async: false
  import ExUnit.CaptureIO

  setup do
    # clear the venues state from these tests
    on_exit(fn ->
      Application.stop(:baz)
      {:ok, _} = Application.ensure_all_started(:baz)
    end)

    :ok
  end

  test "shows each configured venue" do
    venues_config = %{
      "open_sea" => %{
        adapter: Baz.Mock.VenueAdapter,
        collections: "*",
        start_on_boot: false,
        poll_stream_enabled: false,
        websocket_stream_enabled: false,
        credentials: %{}
      }
    }

    {1, _error_loading} = Baz.Venues.load_config(venues_config)

    assert capture_io(&Baz.IEx.venues/0) == """
           +----------+-------------+-------------+---------------------+--------------------------+---------------+
           | Name     | Collections | Credentials | Poll Stream Enabled | WebSocket Stream Enabled | Start On Boot |
           +----------+-------------+-------------+---------------------+--------------------------+---------------+
           | open_sea | *           |             | false               | false                    | false         |
           +----------+-------------+-------------+---------------------+--------------------------+---------------+\n
           """
  end

  test "shows an empty table when there are no venues" do
    assert capture_io(&Baz.IEx.venues/0) == """
           +------+-------------+-------------+---------------------+--------------------------+---------------+
           | Name | Collections | Credentials | Poll Stream Enabled | WebSocket Stream Enabled | Start On Boot |
           +------+-------------+-------------+---------------------+--------------------------+---------------+
           | -    | -           | -           | -                   | -                        | -             |
           +------+-------------+-------------+---------------------+--------------------------+---------------+\n
           """
  end
end

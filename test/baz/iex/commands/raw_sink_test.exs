defmodule Baz.IEx.Commands.RawSinksTest do
  use Baz.TestSupport.DataCase, async: false
  import ExUnit.CaptureIO

  @tag :restart
  test "shows a list of configured raw sinks" do
    put_raw_sinks(:collections, [RawSinkOne, RawSinkTwo])

    assert capture_io(&Baz.IEx.raw_sinks/0) == """
           +-------------------------+--------------------------------------+
           | Resource                | Sinks                                |
           +-------------------------+--------------------------------------+
           | collection_packs        | -                                    |
           | collections             | Elixir.RawSinkOne, Elixir.RawSinkTwo |
           | collection_traits       | -                                    |
           | collection_assets       | -                                    |
           | collection_asset_traits | -                                    |
           | collection_events       | -                                    |
           +-------------------------+--------------------------------------+\n
           """
  end

  test "shows an empty table when there are no raw sinks" do
    assert capture_io(&Baz.IEx.raw_sinks/0) == """
           +-------------------------+-------+
           | Resource                | Sinks |
           +-------------------------+-------+
           | collection_packs        | -     |
           | collections             | -     |
           | collection_traits       | -     |
           | collection_assets       | -     |
           | collection_asset_traits | -     |
           | collection_events       | -     |
           +-------------------------+-------+\n
           """
  end
end

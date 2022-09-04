defmodule Baz.IEx.Commands.NormalizedSinksTest do
  use Baz.TestSupport.DataCase, async: false
  import ExUnit.CaptureIO

  @tag :restart
  test "shows a list of configured normalized sinks" do
    assert capture_io(&Baz.IEx.normalized_sinks/0) == """
           +-------------------------+--------------------------------------+
           | Resource                | Sinks                                |
           +-------------------------+--------------------------------------+
           | collection_packs        | Elixir.Baz.NormalizedSinks.Timescale |
           | collections             | Elixir.Baz.NormalizedSinks.Timescale |
           | collection_traits       | Elixir.Baz.NormalizedSinks.Timescale |
           | collection_assets       | Elixir.Baz.NormalizedSinks.Timescale |
           | collection_asset_traits | Elixir.Baz.NormalizedSinks.Timescale |
           | collection_events       | Elixir.Baz.NormalizedSinks.Timescale |
           +-------------------------+--------------------------------------+\n
           """
  end

  test "shows an empty table when there are no normalized sinks" do
    put_normalized_sinks(:collections, [])

    assert capture_io(&Baz.IEx.normalized_sinks/0) == """
           +-------------------------+--------------------------------------+
           | Resource                | Sinks                                |
           +-------------------------+--------------------------------------+
           | collection_packs        | Elixir.Baz.NormalizedSinks.Timescale |
           | collections             | -                                    |
           | collection_traits       | Elixir.Baz.NormalizedSinks.Timescale |
           | collection_assets       | Elixir.Baz.NormalizedSinks.Timescale |
           | collection_asset_traits | Elixir.Baz.NormalizedSinks.Timescale |
           | collection_events       | Elixir.Baz.NormalizedSinks.Timescale |
           +-------------------------+--------------------------------------+\n
           """
  end
end

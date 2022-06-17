defmodule Baz.IEx.Commands.HelpTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  test "show command usage" do
    assert capture_io(&Baz.IEx.help/0) != ""
  end
end

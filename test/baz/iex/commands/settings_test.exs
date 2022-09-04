defmodule Baz.IEx.Commands.SettingsTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  test "show current values for settings" do
    assert capture_io(&Baz.IEx.settings/0) == """
           +-----------------+-------+
           | Name            | Value |
           +-----------------+-------+
           | max_job_retries | 5     |
           +-----------------+-------+\n
           """
  end
end

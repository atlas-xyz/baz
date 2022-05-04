defmodule BazTest do
  use ExUnit.Case
  doctest Baz

  test "greets the world" do
    assert Baz.hello() == :world
  end
end

defmodule Baz.Sinks.Services.LoadConfig do
  #alias Baz.Sinks
  #alias Baz.MemoryRepo

  @type load_result :: {load_success :: non_neg_integer, load_error :: non_neg_integer}
  @spec call(map) :: load_result
  def call(_sink_config) do
    {0, 0}
  end
end

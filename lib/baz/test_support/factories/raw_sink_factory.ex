defmodule Baz.TestSupport.Factories.RawSinkFactory do
  @type key :: atom
  @type sinks :: [module]

  @spec put_raw_sinks(key, sinks) :: {:ok, {key, sinks}}
  def put_raw_sinks(key, mods) do
    Baz.RawSinks.RawSinkStore.put(key, mods)
  end
end

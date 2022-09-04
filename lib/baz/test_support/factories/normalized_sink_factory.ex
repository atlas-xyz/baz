defmodule Baz.TestSupport.Factories.NormalizedSinkFactory do
  @type key :: atom
  @type sinks :: [module]

  @spec put_normalized_sinks(key, sinks) :: {:ok, {key, sinks}}
  def put_normalized_sinks(key, mods) do
    Baz.NormalizedSinks.NormalizedSinkStore.put(key, mods)
  end
end

defmodule Baz.Settings.Services.LoadConfig do
  alias Baz.Settings

  @settings [
    [name: :max_job_retries, default: 5]
  ]
  @initial_load_result {0, 0}

  @type load_result :: {load_success :: non_neg_integer, load_error :: non_neg_integer}
  @spec call(map) :: load_result
  def call(settings_config) do
    @settings
    |> Enum.map(fn [name: name, default: default] ->
      value = get(settings_config, name, default)
      {name, value}
    end)
    |> Enum.reduce(
      @initial_load_result,
      fn {name, value}, acc ->
        load(name, value, acc)
      end
    )
  end

  defp get(settings_config, key, default) do
    Map.get(settings_config, key) || default
  end

  defp load(resource, sinks, {load_success, load_error}) do
    case Settings.SettingsStore.put(resource, sinks) do
      {:ok, _} ->
        {load_success + 1, load_error}
        # TODO: wrap ETS error
        # {:error, _} -> {load_success, load_error + 1}
    end
  end
end

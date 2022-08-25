defmodule Baz.Settings do
  alias Baz.Settings.Services
  alias Baz.Settings.SettingsStore

  @type name :: SettingsStore.key()

  @spec get(name) :: SettingsStore.find_result()
  def get(name) do
    SettingsStore.find(name)
  end

  @spec all :: SettingsStore.all_result()
  def all do
    SettingsStore.all()
  end

  @spec load_config(map) :: Services.LoadConfig.load_result()
  def load_config(settings_config \\ Application.get_env(:baz, :settings, %{})) do
    Services.LoadConfig.call(settings_config)
  end
end

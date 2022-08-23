defmodule Baz.Application do
  @moduledoc false

  use Application
  require Logger

  @impl true
  def start(_type, _args) do
    children = [
      Baz.MemoryRepo,
      Baz.Repo,
      Baz.RawSinks.RawSinkStore,
      Baz.NormalizedSinks.NormalizedSinkStore,
      Baz.Sinks.Supervisor,
      {Oban, Application.fetch_env!(:baz, Oban)}
      # TODO: Allow this to be configured by apps using baz
      # {Phoenix.PubSub, name: Baz.PubSub}
    ]

    opts = [strategy: :one_for_one, name: Baz.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @impl true
  def start_phase(:venues, _start_type, _phase_args) do
    {load_success, load_error} = Baz.Venues.load_config()
    "loaded venues: success=~w, error=~w" |> format_log_info([load_success, load_error])

    :ok
  end

  @impl true
  def start_phase(:raw_sinks, _start_type, _phase_args) do
    {load_success, load_error} = Baz.RawSinks.load_config()
    "loaded raw sinks: success=~w, error=~w" |> format_log_info([load_success, load_error])

    :ok
  end

  @impl true
  def start_phase(:normalized_sinks, _start_type, _phase_args) do
    {load_success, load_error} = Baz.NormalizedSinks.load_config()
    "loaded normalied sinks: success=~w, error=~w" |> format_log_info([load_success, load_error])

    :ok
  end

  defp format_log_info(format, data) do
    format
    |> :io_lib.format(data)
    |> Logger.info()
  end
end

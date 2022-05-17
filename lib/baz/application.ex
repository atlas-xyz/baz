defmodule Baz.Application do
  @moduledoc false

  use Application
  require Logger

  @impl true
  def start(_type, _args) do
    children = [
      Baz.MemoryRepo,
      Baz.Repo,
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
    Logger.info "loaded venues - success: #{load_success}, error: #{load_error}"

    :ok
  end
end

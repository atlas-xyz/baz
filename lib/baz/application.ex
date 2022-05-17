defmodule Baz.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      Baz.Repo
      # Start the PubSub system
      # {Phoenix.PubSub, name: Baz.PubSub},
    ]

    opts = [strategy: :one_for_one, name: Baz.Supervisor]
    Supervisor.start_link(children, opts)
  end
end

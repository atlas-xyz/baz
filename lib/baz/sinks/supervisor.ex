defmodule Baz.Sinks.Supervisor do
  use Supervisor

  @spec start_link(term) :: Supervisor.on_start()
  def start_link(init_arg) do
    Supervisor.start_link(__MODULE__, init_arg, name: __MODULE__)
  end

  @impl true
  def init(_init_arg) do
    children = [
      :poolboy.child_spec(:worker, sink_worker_pool_config())
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end

  defp sink_worker_pool_config do
    [
      name: {:local, :sink_worker},
      worker_module: Baz.Sinks.Worker,
      size: 5,
      max_overflow: 2
    ]
  end
end

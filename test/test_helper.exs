ExUnit.configure(formatters: [ExUnit.CLIFormatter, ExUnitNotifier])
Ecto.Adapters.SQL.Sandbox.mode(Baz.Repo, :manual)
ExUnit.start()

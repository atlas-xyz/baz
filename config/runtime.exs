import Config

# Database
env = config_env() |> Atom.to_string()
partition = System.get_env("MIX_TEST_PARTITION")
default_database_url = "ecto://postgres:postgres@localhost:5432/baz_?"
configured_database_url = System.get_env("DATABASE_URL") || default_database_url
database_url = "#{String.replace(configured_database_url, "?", env)}#{partition}"
database_pool_size = String.to_integer(System.get_env("POOL_SIZE") || "10")

config :baz, Baz.Repo,
  url: database_url,
  pool_size: database_pool_size

# Oban Job Processing
config :baz, Oban,
  repo: Baz.Repo,
  plugins: [
    Oban.Plugins.Pruner
    # {
    #   Oban.Plugins.Cron,
    #   crontab: [
    #     {"* * * * *", MyApp.MinuteWorker},
    #     {"0 * * * *", MyApp.HourlyWorker, args: %{custom: "arg"}},
    #     {"0 0 * * *", MyApp.DailyWorker, max_attempts: 1},
    #     {"0 12 * * MON", MyApp.MondayWorker, queue: :scheduled, tags: ["mondays"]},
    #     {"@daily", MyApp.AnotherDailyWorker}
    #   ]
    # }
  ],
  queues: [default: 10, imports: 5]

# Baz Core
config :baz, normalized_sinks: %{}
config :baz, venues: %{}

# Logger
config :logger,
  level: :info,
  backends: [{LoggerFileBackend, :file_log}],
  utc_log: true

config :logger, :file_log, path: "./logs/#{Mix.env()}.log"

if System.get_env("DEBUG") == "true" do
  config :logger, level: :debug
end

# Dev
if config_env() == :dev do
  config :baz, Baz.Repo, show_sensitive_data_on_connection_error: true

  config :baz, normalized_sinks: %{
    collection_packs: [Baz.NormalizedSinks.Timescale, Baz.NormalizedSinks.Logger],
    collections: [Baz.NormalizedSinks.Timescale, Baz.NormalizedSinks.Logger],
    collection_traits: [Baz.NormalizedSinks.Timescale, Baz.NormalizedSinks.Logger],
    collection_assets: [Baz.NormalizedSinks.Timescale, Baz.NormalizedSinks.Logger],
    collection_asset_traits: [Baz.NormalizedSinks.Timescale, Baz.NormalizedSinks.Logger],
    collection_events: [Baz.NormalizedSinks.Timescale, Baz.NormalizedSinks.Logger]
  }

  config :baz,
    venues: %{
      "open_sea" => %{
        adapter: Baz.Mock.VenueAdapter,
        collections: "*",
        start_on_boot: false,
        poll_stream_enabled: true,
        websocket_stream_enabled: false,
        credentials: %{}
      },
      "looks_rare" => %{
        adapter: Baz.Mock.VenueAdapter,
        collections: "*",
        start_on_boot: false,
        poll_stream_enabled: true,
        websocket_stream_enabled: false,
        credentials: %{}
      }
    }
end

# Test
if config_env() == :test do
  config :baz, Baz.Repo,
    pool: Ecto.Adapters.SQL.Sandbox,
    show_sensitive_data_on_connection_error: true

  config :baz, Oban, testing: :inline
end

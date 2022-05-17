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
  pool_size: database_pool_size,
  show_sensitive_data_on_connection_error: true

# Baz
config :baz, venues: %{
  "open_sea" => {
    Baz.Mock.VenueAdapter,
    %{
      start_on_boot: false,
      collections: "*",
      events: "*",
      streams: %{
        collections: :enabled,
        events: :enabled
      },
      backfill: %{
        collections: :enabled,
        events: :enabled
      }
    }
  },
  "looks_rare" => {
    Baz.Mock.VenueAdapter,
    %{
      start_on_boot: false,
      collections: "*",
      events: "*",
      streams: %{
        collections: :enabled,
        events: :enabled
      },
      backfill: %{
        collections: :enabled,
        events: :enabled
      }
    }
  }
}

config :baz, venue_subscriptions: %{
  "/consolidated_events/*/boredapeyachtclub" => {
    Baz.ConsolidatedEvents.MergeCollectionSubscriber,
    [
      "/events/*/open_sea:boredapeyachtclub",
      "/events/*/looks_rare:0xBC4CA0EdA7647A8aB7C2061c2E118A18a936f13D"
    ],
    %{}
  },
  "/consolidated_events/item_listed/boredapeyachtclub" => {
    Baz.ConsolidatedEvents.MergeCollectionSubscriber,
    [
      "/events/item_listed/open_sea:boredapeyachtclub",
      "/events/item_listed/looks_rare:0xBC4CA0EdA7647A8aB7C2061c2E118A18a936f13D"
    ],
    %{}
  },
  "/collection_packs/watch" => {
    Baz.CollectionPacks.Watch,
    [
      "/collections/created/open_sea:mutantapeyachtclub",
      "/collections/created/looks_rare:0x60E4d786628Fea6478F785A6d7e704777c86a7c6",
      "/collections/updated/open_sea:mutantapeyachtclub",
      "/collections/updated/looks_rare:0x60E4d786628Fea6478F785A6d7e704777c86a7c6",
      "/collections/deleted/*",
    ],
    %{}
  }
}

# config :baz, collection_pack_provider: Baz.CollectionPacks.EctoProvider
# config :baz, collection_packs: %{
#   "boredapeyachtclub" => [
#     "open_sea/boredapeyachtclub",
#     "looks_rare/0xBC4CA0EdA7647A8aB7C2061c2E118A18a936f13D"
#   ]
# }

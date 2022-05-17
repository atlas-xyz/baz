# Configuration

[Getting Started](./GETTING_STARTED.md) [Commands](./COMMANDS.md) | [Configuration](./CONFIGURATION.md)

To quickly get started, take a look at the [example dev configuration](../config/dev.exs.example) for some available options.

## Global

`baz` is configured with standard [Elixir](https://elixir-lang.org/getting-started/mix-otp/config-and-releases.html)
constructs under the `:baz` application key. Details for each configuration option are provided below:

```elixir
# [default: %{}] [optional] Map of configured venues. See below for more details.
config :baz, venues: %{}
```

## Venues

`baz` adapters abstract a common interface for interacting with venues. They are configured under
the `:baz, :venues` key.

```elixir
config :baz,
  venues: %{
    "open_sea" => %{
      # Module that implements the `Baz.VenueAdapter` behaviour
      adapter: Baz.Mock.VenueAdapter,
      # [default: "*"] [optional] A `juice` query to filter operations
      # https://github.com/rupurt/juice#usage
      collections: "*",
      # [default: false] [optional] Starts the venue streams on initial boot
      start_on_boot: false,
      # [default: false] [optional] Poll stream can be started
      poll_stream_enabled: true,
      # [default: false] [optional] WebSocket stream can be started
      websocket_stream_enabled: false,
      # [default: %{}] [optional] `Map` of named credentials to use private API's on the venue
      credentials: %{}
    }
  }
```

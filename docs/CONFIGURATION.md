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
    "open_sea" => {
      # Module that implements the `Baz.VenueAdapter` behaviour
      Baz.Mock.VenueAdapter,
      %{
        # [default: "*"] [optional] TODO...
        collections: "*",
        # [default: false] [optional] TODO...
        start_on_boot: false,
        # [default: false] [optional] TODO...
        poll_stream_enabled: true,
        # [default: false] [optional] TODO...
        websocket_stream_enabled: false,
        # [default: %{}] [optional] TODO...
        credentials: %{}
      }
    }
  }
```

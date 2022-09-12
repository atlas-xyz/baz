# Baz
[![Build Status](https://github.com/atlas-xyz/baz/workflows/test/badge.svg?branch=main)](https://github.com/atlas-xyz/baz/actions?query=workflow%3Atest)
[![hex.pm version](https://img.shields.io/hexpm/v/baz.svg?style=flat)](https://hex.pm/packages/baz)

A chain native hybrid bazaar engine

[Getting Started](./docs/GETTING_STARTED.md) | [Commands](./docs/COMMANDS.md)

## What Can I Do? TLDR;

Stream NFT market data to create and manage orders with a near-uniform API across multiple venues

## Venues In Progress

| Venue      | Collections | Events | Orders |
| ---------- | :---------: | :----: | :----: |
| OpenSea    |     [ ]     |  [ ]   |  [ ]   |
| LooksRare  |     [ ]     |  [ ]   |  [ ]   |
| X2Y2       |     [ ]     |  [ ]   |  [ ]   |
| Magic Eden |     [ ]     |  [ ]   |  [ ]   |
| Hyperspace |     [ ]     |  [ ]   |  [ ]   |

## Requirements

- TimescaleDB 2.5+
- Erlang 22+
- Elixir 1.13+

## Install

Add the `baz` package to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:baz, "~> 0.0.15"}
  ]
end
```

Create an `.iex.exs` file in the root of your project and import the `baz` helper

```elixir
# .iex.exs
Application.put_env(:elixir, :ansi_enabled, true)

import Baz.IEx
```

Generate migrations

```bash
$ mix baz.gen.migration
```

Run migrations

```bash
$ mix ecto.migrate
```

## Upgrading Baz

Bump the required version number in `mix.exs` and download the dependencies.

```bash
$ mix deps.update baz
```

Regenerate new or updated migrations

```bash
$ mix baz.gen.migration
```

Rerun ecto migrations

```bash
$ mix ecto.migrate
```

## Logging Oban Jobs

To enable `oban` job logging configure `Oban.Telemetry` or your own logger within your supervision tree

```elixir
def start(_type, _args) do
  children = [
    MyApp.Repo,
    MyApp.Endpoint,
    {Oban, oban_opts()}
  ]

  Oban.Telemetry.attach_default_logger(:info)

  Supervisor.start_link(children, [strategy: :one_for_one, name: MyApp.Supervisor])
end
```

## Development

Ensure an instance of TimescaleDB is running

```bash
$ make start.db
```

Run an interactive Elixir shell to control `baz` via the [REPL commands](./docs/COMMANDS.md)

```bash
$ make start
```

## Test

```
$ make test
```

## Help Wanted :)

If you think this `baz` thing might be worthwhile and you don't see a feature
or venue listed we would love your contributions to add them! Feel free to
drop us an email or open a Github issue.

## Authors

- Alex Kwiatkowski - alex@atlas.xyz

## License

`baz` is released under the [MIT license](./LICENSE)

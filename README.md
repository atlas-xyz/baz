# Baz
[![hex.pm version](https://img.shields.io/hexpm/v/baz.svg?style=flat)](https://hex.pm/packages/baz)

A chain native hybrid bazaar engine

[Getting Started](./docs/GETTING_STARTED.md) | [Commands](./docs/COMMANDS.md)

## What Can I Do? TLDR;

Stream NFT market data to create and manage orders with a near-uniform API across multiple venues

## Supported Venues

| Venue      | Collections | Events | Orders |
| ---------- | :---------: | :----: | :----: |
| OpenSea    |     [ ]     |  [ ]   |  [ ]   |

## Venues In Progress

| Venue      | Collections | Events | Orders |
| ---------- | :---------: | :----: | :----: |
| LooksRare  |     [ ]     |  [ ]   |  [ ]   |
| X2Y2       |     [ ]     |  [ ]   |  [ ]   |
| Magic Eden |     [ ]     |  [ ]   |  [ ]   |

## Requirements

- Erlang 22+
- Elixir 1.13+

## Install

Add the `baz` package to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:baz, "~> 0.0.1"}
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
$ mix workbench.gen.migration
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

## Help Wanted :)

If you think this `baz` thing might be worthwhile and you don't see a feature
or venue listed we would love your contributions to add them! Feel free to
drop us an email or open a Github issue.

## Authors

- Alex Kwiatkowski - alex+git@fremantle.io

## License

`baz` is released under the [MIT license](./LICENSE)

# Baz/Commands

[Getting Started](./GETTING_STARTED.md) | [Commands](./COMMANDS.md)

To monitor your instance `baz` provides the following set of IEx commands.

## help

Display the available commands and usage examples

```elixir
iex(1)> help
* collection_packs [where: [...], order: [...]]
* collections [where: [...], order: [...]]
* collection_assets [where: [...], order: [...]]
* collection_events [where: [...], order: [...]]
* venues [where: [...], order: [...]]
* collection_imports [where: [...], order: [...]]
* collection_asset_imports [where: [...], order: [...]]
* collection_event_imports [where: [...], order: [...]]
* import_collection venue: ":name", slug: ":slug"
* import_collection_assets venue: ":name", slug: ":slug", token_ids: [...]
* import_collection_events venue: ":name", slug: ":slug", token_ids: [...], type: ..., before: ..., after: ...
```

## collection_packs

List collection packs that can optionally be filtered and ordered

```elixir
iex(1)> collection_packs
+----+-------+-------+-------------+-----------+------------------+
| ID | Slug  | Name  | Description | Image URI | Banner Image URI |
+----+-------+-------+-------------+-----------+------------------+
| 1  | azuki | Azuki | -           | -         | -                |
+----+-------+-------+-------------+-----------+------------------+
```

## collections

List collections that can optionally be filtered and ordered

```elixir
iex(1)> collections
+----------+-------+-------+-------------+-----------+------------------+
| Venue    | Slug  | Name  | Description | Image URI | Banner Image URI |
+----------+-------+-------+-------------+-----------+------------------+
| open_sea | azuki | Azuki | -           | -         | -                |
+----------+-------+-------+-------------+-----------+------------------+
```

## collection_assets

List collection assets that can optionally be filtered and ordered

```elixir
iex(1)> collection_assets
+----------+-------+----------+----------+
| Venue    | Slug  | Token ID | Name     |
+----------+-------+----------+----------+
| open_sea | azuki | 1        | Azuki #1 |
+----------+-------+----------+----------+
```

## events

List events that can optionally be filtered and ordered

```elixir
iex(1)> events
+-----------------------------+----------+-------+----------+-----------+
| Timestamp                   | Venue    | Slug  | Token ID | Type      |
+-----------------------------+----------+-------+----------+-----------+
| 2022-01-20 12:00:05.123456Z | open_sea | azuki | 1        | item_sold |
+-----------------------------+----------+-------+----------+-----------+
```

## venues

List venues that can optionally be filtered and ordered

```elixir
iex(1)> venues
+------------+-------------+-------------+---------------------+--------------------------+---------------+
| Name       | Collections | Credentials | Poll Stream Enabled | WebSocket Stream Enabled | Start On Boot |
+------------+-------------+-------------+---------------------+--------------------------+---------------+
| open_sea   | *           |             | true                | false                    | false         |
| looks_rare | *           |             | true                | false                    | false         |
+------------+-------------+-------------+---------------------+--------------------------+---------------+
```

## collection_imports

List collection_imports that can optionally be filtered and ordered

```elixir
iex(1)> collection_imports
+----+----------+-------+-----------+---------------------+
| ID | Venue    | Slug  | Status    | Last Updated        |
+----+----------+-------+-----------+---------------------+
| 1  | open_sea | azuki | completed | 2022-05-28 00:16:42 |
| 2  | open_sea | azuki | completed | 2022-05-28 00:22:25 |
+----+----------+-------+-----------+---------------------+
```

## collection_asset_imports

List collection_asset_imports that can optionally be filtered and ordered

```elixir
iex(1)> collection_asset_imports
+----+----------+-------+-----------+-----------+---------------------+
| ID | Venue    | Slug  | Token IDs | Status    | Last Updated        |
+----+----------+-------+-----------+-----------+---------------------+
| 1  | open_sea | azuki | 1         | completed | 2022-05-28 00:16:42 |
| 2  | open_sea | azuki | 1         | completed | 2022-05-28 00:22:25 |
+----+----------+-------+-----------+-----------+---------------------+
```

## event_imports

List event_imports that can optionally be filtered and ordered

```elixir
iex(1)> event_imports
+----------+-------+-----------------------------+-----------------------------+-----------+------------------------+--------+
| Venue    | Slug  | Before                      | After                       | Token IDs | Types                  | Status |
+----------+-------+-----------------------------+-----------------------------+-----------+------------------------+--------+
| open_sea | azuki | 2022-01-20 12:00:05.123456Z | 2022-01-20 12:00:05.123456Z | 1, 2, 3   | item_listed, item_sold | active |
+----------+-------+-----------------------------+-----------------------------+-----------+------------------------+--------+
```

## import_collection

Import a collection from a venue by slug

```elixir
iex(1)> import_collection venue: "open_sea", slug: "doodles-official"
iex(2)> collection_imports
+----+----------+------------------+-----------+---------------------+
| ID | Venue    | Slug             | Status    | Last Updated        |
+----+----------+------------------+-----------+---------------------+
| 1  | open_sea | azuki            | completed | 2022-05-28 00:16:42 |
| 2  | open_sea | azuki            | completed | 2022-05-28 00:22:25 |
| 3  | open_sea | doodles-official | completed | 2022-05-28 00:31:34 |
+----+----------+------------------+-----------+---------------------+
iex(3)> collections
+----------+-------+-------+-------------+-----------+------------------+
| Venue    | Slug  | Name  | Description | Image URI | Banner Image URI |
+----------+-------+-------+-------------+-----------+------------------+
| open_sea | azuki | Azuki | -           | -         | -                |
+----------+-------+-------+-------------+-----------+------------------+
```

## import_collection_assets

Import a collection assets from a venue by slug & token ids

```elixir
iex(1)> import_collection_assets venue: "open_sea", slug: "doodles-official", token_ids: [1]
iex(2)> collection_asset_imports
+----+----------+------------------+-----------+-----------+---------------------+
| ID | Venue    | Slug             | Token IDs | Status    | Last Updated        |
+----+----------+------------------+-----------+-----------+---------------------+
| 1  | open_sea | azuki            | 1         | completed | 2022-05-28 00:16:42 |
| 2  | open_sea | azuki            | 1         | completed | 2022-05-28 00:22:25 |
| 3  | open_sea | doodles-official | 2         | completed | 2022-05-28 00:31:34 |
+----+----------+------------------+-----------+-----------+---------------------+
iex(3)> collection_assets
+----------+-------+----------+----------+
| Venue    | Slug  | Token ID | Name     |
+----------+-------+----------+----------+
| open_sea | azuki | 1        | Azuki #1 |
+----------+-------+----------+----------+
```

## import_collection_events

Import collection events for a collection from a venue by slug

```elixir
iex(1)> import_collection_events venue: "open_sea", slug: "azuki", before: ~U[2022-01-20 12:00:05.123456Z], after: ~U[2022-01-20 12:00:05.123456Z]
iex(2)> collection_event_imports
+----------+-------+-----------------------------+-----------------------------+-----------+-------+--------+
| Venue    | Slug  | Before                      | After                       | Token IDs | Types | Status |
+----------+-------+-----------------------------+-----------------------------+-----------+-------+--------+
| open_sea | azuki | 2022-01-20 12:00:05.123456Z | 2022-01-20 12:00:05.123456Z | -         | -     | active |
+----------+-------+-----------------------------+-----------------------------+-----------+-------+--------+
iex(3)> collection_events
+-----------------------------+----------+-------+----------+-----------+
| Timestamp                   | Venue    | Slug  | Token ID | Type      |
+-----------------------------+----------+-------+----------+-----------+
| 2022-01-20 12:00:02.443472Z | open_sea | azuki | 1        | item_sold |
+-----------------------------+----------+-------+----------+-----------+
```

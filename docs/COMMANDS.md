# Baz/Commands

[Getting Started](./GETTING_STARTED.md) [Commands](./COMMANDS.md)

To monitor your instance, `baz` provides the following set of IEx commands.

## help

Display the available commands and usage examples

```bash
iex(1)> help
* collection_packs [where: [...], order: [...]]
* collections [where: [...], order: [...]]
* venues [where: [...], order: [...]]
* venue_channels [where: [...], order: [...]]
* join_venue_channels [where: [...]]
* leave_venue_channels [where: [...]]
* backfills [collections: [where: [...]], events: [where: [...]]]
* start_backfills [where: [...]]
* stop_backfills [where: [...]]
```

## venues

List venues that can optionally be filtered and ordered

```
iex(4)> venues
+---------+-------------+---------+----------+-------------+---------+---------------+
|      ID | Credentials |  Status | Channels | Quote Depth | Timeout | Start On Boot |
+---------+-------------+---------+----------+-------------+---------+---------------+
| binance |           - | running |        - |           1 |   10000 |          true |
|  bitmex |           - | running |        - |           3 |   10000 |          true |
+---------+-------------+---------+----------+-------------+---------+---------------+
```

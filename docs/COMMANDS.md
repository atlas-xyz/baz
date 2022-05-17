# Baz/Commands

[Getting Started](./GETTING_STARTED.md) | [Commands](./COMMANDS.md)

To monitor your instance `baz` provides the following set of IEx commands.

## help

Display the available commands and usage examples

```bash
iex(1)> help
* collections [where: [...], order: [...]]
* venues [where: [...], order: [...]]
* collection_imports [where: [...], order: [...]]
* import_collection venue: ":name", slug: ":slug"
```

## venues

List collections that can optionally be filtered and ordered

```
iex(2)> collections
+----+----------+-------+-------+-------------+-----------+------------------+
| ID | Venue    | Slug  | Name  | Description | Image URI | Banner Image URI |
+----+----------+-------+-------+-------------+-----------+------------------+
| 1  | open_sea | azuki | Azuki | -           | -         | -                |
+----+----------+-------+-------+-------------+-----------+------------------+
```

## venues

List venues that can optionally be filtered and ordered

```
iex(3)> venues
+------------+-------------+-------------+---------------------+--------------------------+---------------+
| Name       | Collections | Credentials | Poll Stream Enabled | WebSocket Stream Enabled | Start On Boot |
+------------+-------------+-------------+---------------------+--------------------------+---------------+
| open_sea   | *           |             | true                | false                    | false         |
| looks_rare | *           |             | true                | false                    | false         |
+------------+-------------+-------------+---------------------+--------------------------+---------------+
```

## collection_imports

List collection_imports that can optionally be filtered and ordered

```
iex(4)> collection_imports
+----+----------+-------+-----------+---------------------+
| ID | Venue    | Slug  | Status    | Last Updated        |
+----+----------+-------+-----------+---------------------+
| 1  | open_sea | azuki | completed | 2022-05-28 00:16:42 |
| 2  | open_sea | azuki | completed | 2022-05-28 00:22:25 |
+----+----------+-------+-----------+---------------------+
```

## import_collection

Import a collection from a venue by slug

```
iex(5)> import_collection venue: "open_sea", slug: "doodles-official"
iex(6> collection_imports
+----+----------+------------------+-----------+---------------------+
| ID | Venue    | Slug             | Status    | Last Updated        |
+----+----------+------------------+-----------+---------------------+
| 1  | open_sea | azuki            | completed | 2022-05-28 00:16:42 |
| 2  | open_sea | azuki            | completed | 2022-05-28 00:22:25 |
| 3  | open_sea | doodles-official | completed | 2022-05-28 00:31:34 |
+----+----------+------------------+-----------+---------------------+
```

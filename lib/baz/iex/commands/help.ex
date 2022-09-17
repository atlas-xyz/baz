defmodule Baz.IEx.Commands.Help do
  @moduledoc """
  Display the available commands and their usage
  """

  @spec help :: no_return
  def help do
    """
    === [merged local]
    - collection_packs [where: [...], order: [...]]

    === [venue local]
    - collections [where: [...], order: [...]]
    - collection_assets [where: [...], order: [...]]
    - collection_events [where: [...], order: [...]]

    === [venue management]
    - venues [where: [...], order: [...]]

    === [web sockets]
    - venue_web_sockets [where: [...], order: [...]]
    - start_venue_web_socket venue: ":name"
    - subscribe_venue_web_socket venue: ":name", slugs: "*"

    === [imports]
    - collection_imports [where: [...], order: [...]]
    - collection_asset_imports [where: [...], order: [...]]
    - collection_event_imports [where: [...], order: [...]]
    - import_collection venue: ":name", slug: ":slug"
    - import_collection_assets venue: ":name", slug: ":slug", token_ids: [...]
    - import_collection_events venue: ":name", slug: ":slug", token_ids: [...], type: ..., before: ..., after: ...

    === [system]
    - settings
    - raw_sinks
    - normalized_sinks
    """
    |> IO.puts()

    IEx.dont_display_result()
  end
end

defmodule Baz.IEx.Commands.Help do
  @moduledoc """
  Display the available commands and their usage
  """

  @spec help :: no_return
  def help do
    """
    * sinks
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
    """
    |> IO.puts()

    IEx.dont_display_result()
  end
end

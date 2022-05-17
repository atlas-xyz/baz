defmodule Baz.IEx.Commands.Help do
  @moduledoc """
  Display the available commands and their usage
  """

  @spec help :: no_return
  def help do
    """
    * venues [where: [...], order: [...]]
    * start_venues [where: [...]]
    * stop_venues [where: [...]]
    * collection_packs [where: [...], order: [...]]
    * collections [where: [...], order: [...]]
    * backfill [collections: [where: [...]], events: [where: [...]]]
    """
    |> IO.puts()

    IEx.dont_display_result()
  end
end

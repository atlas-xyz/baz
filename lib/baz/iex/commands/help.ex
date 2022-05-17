defmodule Baz.IEx.Commands.Help do
  @moduledoc """
  Display the available commands and their usage
  """

  @spec help :: no_return
  def help do
    """
    * collections [where: [...], order: [...]]
    * venues [where: [...], order: [...]]
    * collection_imports [where: [...], order: [...]]
    * import_collection venue: ":name", slug: ":slug"
    """
    |> IO.puts()

    IEx.dont_display_result()
  end
end

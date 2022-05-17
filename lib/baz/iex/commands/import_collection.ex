defmodule Baz.IEx.Commands.ImportCollection do
  @moduledoc """
  Import a collection from a venue by matching slug
  """

  @type opts :: [venue: String.t(), slug: String.t()]

  @spec create(opts) :: no_return
  def create(opts) do
    venue = Keyword.fetch!(opts, :venue)
    slug = Keyword.fetch!(opts, :slug)
    attrs = %{"venue" => venue, "slug" => slug}
    {:ok, _} = Baz.CollectionImports.create_collection_import(attrs)

    IEx.dont_display_result()
  end
end

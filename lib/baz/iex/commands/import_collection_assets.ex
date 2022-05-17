defmodule Baz.IEx.Commands.ImportCollectionAssets do
  @moduledoc """
  Import the given collection_assets from a venue by matching slug & token_ids
  """

  @type opts :: [venue: String.t(), slug: String.t(), token_ids: [non_neg_integer]]

  @spec create(opts) :: no_return
  def create(opts) do
    venue = Keyword.fetch!(opts, :venue)
    slug = Keyword.fetch!(opts, :slug)
    token_ids = Keyword.fetch!(opts, :token_ids)
    attrs = %{"venue" => venue, "slug" => slug, "token_ids" => token_ids}
    {:ok, _} = Baz.CollectionAssetImports.create_collection_asset_import(attrs)

    IEx.dont_display_result()
  end
end

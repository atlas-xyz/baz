defmodule Baz.IEx.Commands.ImportCollectionAssets do
  @moduledoc """
  Import a collections from a venue by matching slug.

  When no token_ids are given it will import all assets. Specific tokens can be provided as a
  list of token_ids.
  """

  @type venue :: String.t()
  @type slug :: String.t()
  @type required_opts :: [venue: venue, slug: slug]
  @type all_opts :: [venue: venue, slug: slug, token_ids: [non_neg_integer]]
  @type opts :: required_opts | all_opts

  @spec create(opts) :: no_return
  def create(opts) do
    attrs = build_attrs(opts)
    {:ok, _} = Baz.CollectionAssetImports.create_collection_asset_import(attrs)

    IEx.dont_display_result()
  end

  defp build_attrs(opts) do
    venue = Keyword.fetch!(opts, :venue)
    slug = Keyword.fetch!(opts, :slug)
    token_ids = Keyword.get(opts, :token_ids)
    {:ok, max_job_retries} = Baz.Settings.get(:max_job_retries)

    %{
      "venue" => venue,
      "slug" => slug,
      "token_ids" => token_ids,
      "max_retries" => max_job_retries
    }
  end
end

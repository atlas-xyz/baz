defmodule Baz.Mock.VenueAdapter do
  @moduledoc """
  Baz adapter for test mocks
  """

  @behaviour Baz.VenueAdapter

  @type venue :: Baz.VenueAdapter.venue()
  @type collection_slug :: Baz.VenueAdapter.collection_slug()

  @spec get_collection_by_slug(venue, collection_slug) :: Baz.VenueAdapter.get_collection_by_slug_result()
  def get_collection_by_slug(venue, slug) do
    case slug do
      "azuki" ->
        Baz.Collections.collection_changeset(%{
          venue: venue.name,
          slug: slug,
          name: "Azuki"
        })

      _ ->
        {:error, :not_found}
    end
  end

  @type token_ids :: Baz.VenueAdapter.token_ids()

  @spec get_collection_assets_by_slug(venue, collection_slug, token_ids) :: Baz.VenueAdapter.get_collection_assets_by_slug_result()
  def get_collection_assets_by_slug(venue, slug, token_ids) do
    case slug do
      "azuki" -> 
        assets =
          token_ids
          |> Enum.map(fn token_id ->
            Baz.CollectionAssets.collection_asset_changeset(%{
              venue: venue.name,
              slug: slug,
              token_id: token_id,
              name: "Azuki ##{token_id}"
            })
          end)

        assets

      _ ->
        {:error, :not_found}
    end
  end
end

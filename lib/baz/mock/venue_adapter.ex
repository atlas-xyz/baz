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
        Baz.Collections.collection_changeset(%{venue: venue.name, slug: slug, name: "Azuki"})

      _ ->
        {:error, :not_found}
    end
  end
end

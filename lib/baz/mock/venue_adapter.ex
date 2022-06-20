defmodule Baz.Mock.VenueAdapter do
  @moduledoc """
  Baz adapter for test mocks
  """

  @behaviour Baz.VenueAdapter

  @impl true
  def fetch_collection_by_slug(venue, slug) do
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

  @impl true
  def fetch_collection_asset_page_by_slug(venue, slug, token_ids, _page_cursor) do
    case slug do
      "azuki" ->
        assets =
          case token_ids do
            nil ->
              # TODO: DRY this up
              [1, 2, 3, 4, 5]
              |> Enum.map(fn token_id ->
                Baz.CollectionAssets.collection_asset_changeset(%{
                  venue: venue.name,
                  slug: slug,
                  token_id: token_id,
                  name: "Azuki ##{token_id}"
                })
              end)

            _ ->
              token_ids
              |> Enum.map(fn token_id ->
                Baz.CollectionAssets.collection_asset_changeset(%{
                  venue: venue.name,
                  slug: slug,
                  token_id: token_id,
                  name: "Azuki ##{token_id}"
                })
              end)
          end

        %Baz.Page{data: assets}

      _ ->
        {:error, :not_found}
    end
  end

  @impl true
  def fetch_collection_event_page_by_slug(venue, slug, token_ids, _page_cursor) do
    case slug do
      "azuki" ->
        now = DateTime.utc_now()

        events =
          case token_ids do
            nil ->
              # TODO: DRY this up
              [1, 2, 3, 4, 5]
              |> Enum.map(fn token_id ->
                Baz.CollectionEvents.collection_event_changeset(%{
                  venue: venue.name,
                  slug: slug,
                  token_id: token_id,
                  event_type: :item_listed,
                  event_timestamp: now |> DateTime.add(-token_id)
                })
              end)

            _ ->
              token_ids
              |> Enum.map(fn token_id ->
                Baz.CollectionEvents.collection_event_changeset(%{
                  venue: venue.name,
                  slug: slug,
                  token_id: token_id,
                  event_type: :item_listed,
                  event_timestamp: now |> DateTime.add(-token_id)
                })
              end)
          end

        %Baz.Page{data: events}

      _ ->
        {:error, :not_found}
    end
  end
end

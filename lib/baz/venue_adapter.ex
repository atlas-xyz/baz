defmodule Baz.VenueAdapter do
  alias Baz.Collections

  @type address :: String.t()
  @type venue :: struct
  @type collection_slug :: String.t()
  @type collection :: Collections.Collection.t()
  @type shared_errors :: :not_implemented | {:unhandled, term} | term

  @type fetch_collection_by_slug_result :: collection | {:error, shared_errors}
  @callback fetch_collection_by_slug(venue, collection_slug) :: fetch_collection_by_slug_result

  @spec fetch_collection_by_slug(venue, collection_slug) :: fetch_collection_by_slug_result
  def fetch_collection_by_slug(venue, slug) do
    venue.adapter.fetch_collection_by_slug(venue, slug)
  rescue
    e ->
      {:error, {:unhandled, {e, __STACKTRACE__}}}
  end

  @type token_id :: non_neg_integer
  @type token_ids :: [token_id]
  @type page_cursor :: Baz.Page.cursor()

  @type fetch_collection_asset_page_by_slug_result :: Baz.Page.t() | {:error, shared_errors}
  @callback fetch_collection_asset_page_by_slug(venue, collection_slug, token_ids, page_cursor) ::
              fetch_collection_asset_page_by_slug_result

  @spec fetch_collection_asset_page_by_slug(venue, collection_slug, token_ids, page_cursor) ::
          fetch_collection_asset_page_by_slug_result
  def fetch_collection_asset_page_by_slug(venue, slug, token_ids, page_cursor) do
    venue.adapter.fetch_collection_asset_page_by_slug(
      venue,
      slug,
      token_ids,
      page_cursor
    )
  rescue
    e ->
      {:error, {:unhandled, {e, __STACKTRACE__}}}
  end

  @type fetch_collection_event_page_by_slug_result :: Baz.Page.t() | {:error, shared_errors}
  @callback fetch_collection_event_page_by_slug(venue, collection_slug, token_ids, page_cursor) ::
              fetch_collection_event_page_by_slug_result

  @spec fetch_collection_event_page_by_slug(venue, collection_slug, token_ids, page_cursor) ::
          fetch_collection_event_page_by_slug_result
  def fetch_collection_event_page_by_slug(venue, slug, token_ids, page_cursor) do
    venue.adapter.fetch_collection_event_page_by_slug(
      venue,
      slug,
      token_ids,
      page_cursor
    )
  rescue
    e ->
      {:error, {:unhandled, {e, __STACKTRACE__}}}
  end
end

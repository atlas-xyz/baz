defmodule Baz.VenueAdapter do
  alias Baz.Collections

  @type address :: String.t()
  @type venue :: struct
  @type collection_slug :: String.t()
  @type collection :: Collections.Collection.t()
  @type shared_errors :: :not_implemented | {:unhandled, term} | term

  @type get_collection_by_slug_result :: Ecto.Changeset.t() | {:error, shared_errors}
  @callback get_collection_by_slug(venue, collection_slug) :: get_collection_by_slug_result

  @spec get_collection_by_slug(venue, collection_slug) :: get_collection_by_slug_result
  def get_collection_by_slug(venue, slug) do
    venue.adapter.get_collection_by_slug(venue, slug)
  rescue
    e ->
      {:error, {:unhandled, {e, __STACKTRACE__}}}
  end

  @type token_id :: non_neg_integer
  @type token_ids :: [token_id]

  @type get_collection_assets_by_slug_result :: [Ecto.Changeset.t()] | {:error, shared_errors}
  @callback get_collection_assets_by_slug(venue, address, token_ids) :: get_collection_assets_by_slug_result

  @spec get_collection_assets_by_slug(venue, address, token_ids) :: get_collection_assets_by_slug_result
  def get_collection_assets_by_slug(venue, collection_address, token_ids) do
    venue.adapter.get_collection_assets_by_slug(venue, collection_address, token_ids)
  rescue
    e ->
      {:error, {:unhandled, {e, __STACKTRACE__}}}
  end
end

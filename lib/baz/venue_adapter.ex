defmodule Baz.VenueAdapter do
  alias Baz.Collections

  @type venue :: struct
  @type collection_slug :: String.t()
  @type collection :: Collections.Collection.t()
  @type shared_errors :: :not_implemented | term
  @type get_collection_by_slug_result :: Ecto.Changeset.t() | {:error, shared_errors}

  @callback get_collection_by_slug(venue, collection_slug) :: get_collection_by_slug_result

  @spec get_collection_by_slug(venue, collection_slug) :: get_collection_by_slug_result
  def get_collection_by_slug(venue, collection_slug) do
    venue.adapter.get_collection_by_slug(venue, collection_slug)
  rescue
    e ->
      {:error, {:unhandled, {e, __STACKTRACE__}}}
  end
end

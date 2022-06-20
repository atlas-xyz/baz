defmodule Baz.CollectionEvents.CollectionEvent do
  @moduledoc """
  CollectionEvent resource
  """

  use Ecto.Schema
  import Ecto.Changeset

  @type t :: Ecto.Schema.t()

  schema "collection_events" do
    field(:venue, :string)
    field(:slug, :string)
    field(:token_id, :integer)

    field(:event_type, Ecto.Enum,
      values: [
        :item_listed,
        :item_sold,
        :item_transferred,
        :item_metadata_update,
        :item_canceled,
        :item_received_offer,
        :item_received_bid
      ]
    )

    field(:event_timestamp, :utc_datetime_usec)

    timestamps()
  end

  @doc false
  def changeset(collection, attrs) do
    collection
    |> cast(attrs, [
      :venue,
      :slug,
      :token_id,
      :event_type,
      :event_timestamp
    ])
    |> validate_required([
      :venue,
      :slug,
      :token_id,
      :event_type,
      :event_timestamp
    ])
  end
end

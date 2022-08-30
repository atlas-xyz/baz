defmodule Baz.CollectionEvents.CollectionEvent do
  @moduledoc """
  CollectionEvent resource
  """

  use Ecto.Schema
  import Ecto.Changeset

  @type t :: Ecto.Schema.t()

  @primary_key false

  schema "collection_events" do
    field(:event_timestamp, :utc_datetime_usec)

    field(:event_type, Ecto.Enum,
      values: [
        :item_listed,
        :item_sold,
        :item_transferred,
        :item_metadata_update,
        :item_canceled,
        :item_received_offer,
        :item_received_bid,
        :created,
        :successful,
        :collection_offer,
        :trait_offer,
        :bid_entered,
        :cancelled,
        :transfer
      ]
    )

    field(:venue, :string)
    field(:slug, :string)
    field(:token_id, :integer)
    field(:id, :integer)

    timestamps()
  end

  @doc false
  def changeset(collection, attrs) do
    collection
    |> cast(attrs, [
      :event_timestamp,
      :event_type,
      :venue,
      :slug,
      :token_id,
      :id
    ])
    |> validate_required([
      :event_timestamp,
      :event_type,
      :venue,
      :slug,
      :id
    ])
  end
end

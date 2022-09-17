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
        :bid_entered,
        :bid_withdrawn,
        :cancelled,
        :collection_offer,
        :created,
        :offer_entered,
        :successful,
        :trait_offer,
        :transfer
      ]
    )

    field(:venue, :string)
    field(:slug, :string)
    field(:token_id, :string)
    field(:source_id, :string)

    timestamps()
  end

  @doc false
  def changeset(collection, attrs) do
    collection
    |> cast(attrs, [
      :event_timestamp,
      :event_type,
      :source_id,
      :slug,
      :token_id,
      :venue
    ])
    |> validate_required([
      :event_timestamp,
      :event_type,
      :source_id,
      :slug,
      :venue
    ])
    |> unique_constraint(([:event_timestamp, :event_type, :source_id, :slug, :token_id, :venue ]))
  end
end

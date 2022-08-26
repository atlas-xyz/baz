defmodule Baz.CollectionAssets.CollectionAsset do
  @moduledoc """
  CollectionAsset resource
  """

  use Ecto.Schema
  import Ecto.Changeset

  @type t :: Ecto.Schema.t()

  schema "collection_assets" do
    field(:venue, :string)
    field(:slug, :string)
    field(:token_id, :string)
    field(:name, :string)
    field(:description, :string)
    field(:background_color, :string)
    field(:image_uri, :string)
    field(:image_preview_uri, :string)
    field(:image_thumbnail_uri, :string)
    field(:image_original_uri, :string)
    field(:animation_uri, :string)
    field(:animation_original_uri, :string)
    field(:is_nsfw, :boolean)
    # Interesting extra information from OS API
    # permalink: String.t(),
    # external_link: String.t(),
    # asset_contract: map,
    # collection: String.t(),
    # is_nsfw: boolean,
    # decimals: non_neg_integer | nil,
    # token_metadata: String.t(),
    # creator: map,
    # traits: [map],
    # is_presale: boolean,
    # transfer_fee_payment_token: term | nil,
    # transfer_fee: term | nil,
    # related_assets: list,
    # auctions: list,
    # supports_wyvern: boolean,

    timestamps()
  end

  @doc false
  def changeset(collection, attrs) do
    collection
    |> cast(attrs, [
      :venue,
      :slug,
      :token_id,
      :name,
      :description,
      :background_color,
      :image_uri,
      :image_preview_uri,
      :image_thumbnail_uri,
      :image_original_uri,
      :animation_uri,
      :animation_original_uri,
      :is_nsfw
    ])
    |> validate_required([:venue, :slug, :token_id])
    |> unique_constraint([:venue, :slug, :token_id])
  end
end

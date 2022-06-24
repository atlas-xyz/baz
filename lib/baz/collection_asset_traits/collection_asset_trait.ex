defmodule Baz.CollectionAssetTraits.CollectionAssetTrait do
  @moduledoc """
  CollectionAssetTrait resource
  """

  use Ecto.Schema
  import Ecto.Changeset
  alias Baz.CollectionAssets.CollectionAsset

  @type t :: Ecto.Schema.t()

  schema "collection_asset_traits" do
    belongs_to(:collection_asset_id, CollectionAsset)
    field(:trait_type, :string)
    field(:value, :string)
    field(:display_type, :string)

    timestamps()
  end

  @doc false
  def changeset(collection_asset_trait, attrs) do
    collection_asset_trait
    |> cast(attrs, [:collection_asset_id, :trait_type, :value, :display_type])
    |> validate_required([:collection_asset_id, :trait_type, :value])
  end
end

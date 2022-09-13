defmodule Baz.CollectionPacks.CollectionPack do
  @moduledoc """
  CollectionPack resource
  """

  @type t :: struct

  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, Ecto.UUID, autogenerate: true}

  schema "collection_packs" do
    field(:slug, :string)
    field(:name, :string)
    field(:description, :string)
    field(:image_uri, :string)
    field(:banner_image_uri, :string)
    field(:is_verified, :boolean)

    field(:status, Ecto.Enum,
      values: [
        :visible,
        :hidden,
        :scheduled
      ]
    )

    timestamps()
  end

  @doc false
  def changeset(collection_pack, attrs) do
    collection_pack
    |> cast(attrs, [
      :slug,
      :name,
      :description,
      :image_uri,
      :banner_image_uri,
      :is_verified,
      :status
    ])
    |> validate_required([:slug])
  end
end

defmodule Baz.CollectionPacks.CollectionPack do
  @moduledoc """
  CollectionPack resource
  """

  use Ecto.Schema
  import Ecto.Changeset

  schema "collection_packs" do
    field :slug, :string
    field :description, :string
    field :image_uri, :string
    field :banner_image_uri, :string

    timestamps()
  end

  @doc false
  def changeset(collection, attrs) do
    collection
    |> cast(attrs, [:slug, :description, :image_uri, :banner_image_uri])
    |> validate_required([:slug])
  end
end

defmodule Baz.Collections.Collection do
  @moduledoc """
  Collection resource
  """

  use Ecto.Schema
  import Ecto.Changeset

  @type t :: Ecto.Schema.t()

  schema "collections" do
    field(:venue, :string)
    field(:slug, :string)
    field(:name, :string)
    field(:description, :string)
    field(:image_uri, :string)
    field(:banner_image_uri, :string)

    timestamps()
  end

  @doc false
  def changeset(collection, attrs) do
    collection
    |> cast(attrs, [:venue, :slug, :name, :description, :image_uri, :banner_image_uri])
    |> validate_required([:venue, :slug, :name])
  end
end

defmodule Baz.CollectionAssetImports.CollectionAssetImport do
  @moduledoc """
  CollectionAssetImport resource
  """

  @type t :: struct

  use Ecto.Schema
  import Ecto.Changeset

  schema "collection_asset_imports" do
    field :venue, :string
    field :slug, :string
    field :token_ids, {:array, :integer}
    field :status, :string

    timestamps()
  end

  @doc false
  def changeset(collection, attrs) do
    collection
    |> cast(attrs, [:venue, :slug, :token_ids, :status])
    |> validate_required([:venue, :slug, :status])
  end
end

defmodule Baz.CollectionAssetImports.CollectionAssetImport do
  @moduledoc """
  CollectionAssetImport resource
  """

  @type id :: non_neg_integer
  @type t :: struct

  use Ecto.Schema
  import Ecto.Changeset
  alias Baz.CollectionAssetImportPages.CollectionAssetImportPage

  schema "collection_asset_imports" do
    field :venue, :string
    field :slug, :string
    field :token_ids, {:array, :integer}
    field :status, :string
    has_many :pages, CollectionAssetImportPage

    timestamps()
  end

  @doc false
  def changeset(collection_asset_import, attrs) do
    collection_asset_import
    |> cast(attrs, [:venue, :slug, :token_ids, :status])
    |> validate_required([:venue, :slug, :status])
  end
end

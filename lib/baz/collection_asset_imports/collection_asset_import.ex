defmodule Baz.CollectionAssetImports.CollectionAssetImport do
  @moduledoc """
  CollectionAssetImport resource
  """

  use Ecto.Schema
  import Ecto.Changeset
  alias Baz.CollectionAssetImportPages.CollectionAssetImportPage

  @type id :: non_neg_integer
  @type t :: Ecto.Schema.t()

  schema "collection_asset_imports" do
    field(:venue, :string)
    field(:slug, :string)
    field(:token_ids, Baz.EctoTypes.Integers)
    field(:status, :string)
    has_many(:pages, CollectionAssetImportPage)

    timestamps(type: :utc_datetime_usec)
  end

  @doc false
  def changeset(collection_asset_import, attrs) do
    collection_asset_import
    |> cast(attrs, [:venue, :slug, :token_ids, :status])
    |> validate_required([:venue, :slug, :status])
  end
end

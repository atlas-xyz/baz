defmodule Baz.CollectionAssetImports.CollectionAssetImport do
  @moduledoc """
  CollectionAssetImport resource
  """

  use Ecto.Schema
  import Ecto.Changeset
  alias Baz.CollectionAssetImportPages.CollectionAssetImportPage

  @type id :: non_neg_integer
  @type t :: Ecto.Schema.t()

  @primary_key {:id, Ecto.UUID, autogenerate: true}

  schema "collection_asset_imports" do
    field(:venue, :string)
    field(:slug, :string)
    field(:token_ids, Baz.EctoTypes.Strings)
    field :max_retries, :integer
    field(:status, :string)
    has_many(:pages, CollectionAssetImportPage)

    timestamps(type: :utc_datetime_usec)
  end

  @doc false
  def changeset(collection_asset_import, attrs) do
    collection_asset_import
    |> cast(attrs, [:venue, :slug, :token_ids, :max_retries, :status])
    |> validate_required([:venue, :slug, :max_retries, :status])
  end
end

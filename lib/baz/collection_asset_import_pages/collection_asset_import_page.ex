defmodule Baz.CollectionAssetImportPages.CollectionAssetImportPage do
  @moduledoc """
  CollectionAssetImportPage resource
  """

  use Ecto.Schema
  import Ecto.Changeset
  alias Baz.CollectionAssetImports.CollectionAssetImport

  @type t :: Ecto.Schema.t()

  @primary_key {:id, Ecto.UUID, autogenerate: true}
  @foreign_key_type Ecto.UUID

  schema "collection_asset_import_pages" do
    field(:page_number, :integer)
    field(:next_page_cursor, :string)
    belongs_to(:collection_asset_import, CollectionAssetImport)

    timestamps(type: :utc_datetime_usec)
  end

  @doc false
  def changeset(page, attrs) do
    page
    |> cast(attrs, [:page_number, :next_page_cursor])
    |> cast_assoc(:collection_asset_import)
    |> validate_required([:page_number, :collection_asset_import])
    |> unique_constraint([:collection_asset_import, :page_number])
  end
end

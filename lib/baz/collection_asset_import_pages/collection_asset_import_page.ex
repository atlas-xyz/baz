defmodule Baz.CollectionAssetImportPages.CollectionAssetImportPage do
  @moduledoc """
  CollectionAssetImportPage resource
  """

  @type t :: Ecto.Schema.t()

  use Ecto.Schema
  import Ecto.Changeset
  alias Baz.CollectionAssetImports.CollectionAssetImport

  schema "collection_asset_import_pages" do
    field(:page_number, :integer)
    field(:next_page_cursor, :string)
    belongs_to(:collection_asset_import, CollectionAssetImport)

    timestamps()
  end

  @doc false
  def changeset(page, attrs) do
    page
    |> cast(attrs, [:page_number, :next_page_cursor])
    |> cast_assoc(:collection_asset_import)
    |> validate_required([:page_number, :collection_asset_import])
  end
end

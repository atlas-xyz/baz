defmodule Baz.CollectionAssetImportPages do
  alias Baz.Repo
  alias Baz.CollectionAssetImportPages.CollectionAssetImportPage

  @type collection_asset_import_page :: CollectionAssetImportPage.t()

  @doc """
  Gets a single collection_asset_import_page.

  Raises `Ecto.NoResultsError` if the CollectionAssetImportPage does not exist.

  ## Examples

      iex> get_collection_asset_import_page!(123)
      %CollectionAssetImportPage{}

      iex> get_collection_asset_import_page!(456)
      ** (Ecto.NoResultsError)

  """
  @spec get_collection_asset_import_page!(term) :: term
  def get_collection_asset_import_page!(id), do: Repo.get!(CollectionAssetImportPage, id)

  @spec collection_asset_import_page_changeset(map) :: Ecto.Changeset.t() | {:error, term}
  def collection_asset_import_page_changeset(attrs) do
    CollectionAssetImportPage.changeset(%CollectionAssetImportPage{}, attrs)
  end
end

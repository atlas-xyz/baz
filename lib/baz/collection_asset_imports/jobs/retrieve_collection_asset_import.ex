defmodule Baz.CollectionAssetImports.Jobs.RetrieveCollectionAsset do
  use Oban.Worker, queue: :imports
  require Logger
  alias Baz.Repo

  @impl Oban.Worker
  def perform(%Oban.Job{args: %{"id" => id}}) do
    collection_asset_import = Baz.CollectionAssetImports.get_collection_asset_import!(id)
    {:ok, collection_asset_import} = update_import_status(collection_asset_import, "executing")
    result = get_and_upsert_collection(collection_asset_import)
    {:ok, _collection_asset_import} = update_import_status(collection_asset_import, "completed")

    result
  rescue
    e ->
      "unhandled error retrieving collection error=~s, stacktrace=~s"
      |> :io_lib.format([
        e |> inspect,
        __STACKTRACE__ |> inspect
      ])
      |> Logger.error()
  end

  defp get_and_upsert_collection(asset_import) do
    case get_assets(asset_import) do
      assets when is_list(assets) ->
        # TODO: support multiple strategies
        # - :nothing
        # - :replace
        assets
        |> Enum.with_index()
        |> Enum.reduce(
          Ecto.Multi.new(),
          fn {asset, index}, multi ->
            Ecto.Multi.insert(
              multi,
              {:collection_asset, index},
              asset
            )
          end
        )
        |> Repo.transaction()

      {:error, reason} = error ->
        "could not retrieve collection assets slug=~s, venue=~s, token_ids: ~w, reason=~s"
        |> :io_lib.format([
          asset_import.slug,
          asset_import.venue,
          asset_import.token_ids,
          reason |> inspect
        ])
        |> Logger.error()

        error
    end
  end

  defp update_import_status(collection_asset_import, status) do
    Baz.CollectionAssetImports.update_collection_asset_import(collection_asset_import, %{status: status})
  end

  defp get_assets(asset_import) do
    venue = Baz.Venues.get_venue!(asset_import.venue)

    Baz.VenueAdapter.get_collection_assets_by_slug(
      venue,
      asset_import.slug,
      asset_import.token_ids
    )
  end
end

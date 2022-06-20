defmodule Baz.CollectionAssetImports.Jobs.PullCollectionAssets do
  @moduledoc """
  Fetches the collection assets, a page at a time matching the import filters:

  - token_ids
  """

  use Oban.Worker, queue: :imports
  require Logger

  @impl Oban.Worker
  def perform(%Oban.Job{args: %{"collection_asset_import_id" => import_id}}) do
    collection_asset_import = Baz.CollectionAssetImports.get_collection_asset_import!(import_id)
    {:ok, _collection_asset_import} = update_import_status(collection_asset_import, "executing")

    %{collection_asset_import_id: import_id, page_number: 0, page_cursor: nil}
    |> Baz.CollectionAssetImports.Jobs.PullCollectionAssetsByPage.new()
    |> Oban.insert()
  rescue
    e ->
      "unhandled error retrieving collection assets error=~s, stacktrace=~s"
      |> :io_lib.format([
        e |> inspect,
        __STACKTRACE__ |> inspect
      ])
      |> Logger.error()
  end

  defp update_import_status(collection_asset_import, status) do
    Baz.CollectionAssetImports.update_collection_asset_import(collection_asset_import, %{
      status: status
    })
  end
end

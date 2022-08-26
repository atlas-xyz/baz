defmodule Baz.CollectionAssetImports.Jobs.PullCollectionAssets do
  @moduledoc """
  Fetch collection assets one page at a time matching the import filters:

  - venue
  - slug
  - token_ids
  """

  use Oban.Worker, queue: :imports
  require Logger

  @impl Oban.Worker
  def perform(%Oban.Job{args: %{"collection_asset_import_id" => import_id}}) do
    asset_import = Baz.CollectionAssetImports.get_collection_asset_import!(import_id)

    %{
      collection_asset_import_id: asset_import.id,
      retries: 0,
      page_number: 0,
      page_cursor: nil
    }
    |> Baz.CollectionAssetImports.Jobs.PullCollectionAssetsByPage.new()
    |> Oban.insert()
  rescue
    e ->
      "unhandled error pulling collection assets error=~s, stacktrace=~s"
      |> format_log_error([inspect(e), inspect(__STACKTRACE__)])
  end

  defp format_log_error(format, data) do
    format
    |> :io_lib.format(data)
    |> Logger.error()
  end
end

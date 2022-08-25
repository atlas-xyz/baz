defmodule Baz.IEx.Commands.ImportCollectionEvents do
  @moduledoc """
  Import collection_events from a venue by matching slug and optional filter attributes
  """

  @type opts :: [venue: String.t(), slug: String.t()]

  @spec create(opts) :: no_return
  def create(opts) do
    attrs = build_attrs(opts)
    {:ok, _} = Baz.CollectionEventImports.create_collection_event_import(attrs)

    IEx.dont_display_result()
  end

  defp build_attrs(opts) do
    venue = Keyword.fetch!(opts, :venue)
    slug = Keyword.fetch!(opts, :slug)
    {:ok, max_job_retries} = Baz.Settings.get(:max_job_retries)

    %{"venue" => venue, "slug" => slug, "max_retries" => max_job_retries}
  end
end

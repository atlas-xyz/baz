defmodule Baz.IEx.Commands.ImportCollection do
  @moduledoc """
  Import a collection from a venue by matching slug
  """

  @type opts :: [venue: String.t(), slug: String.t()]

  @spec create(opts) :: no_return
  def create(opts) do
    attrs = build_attrs(opts)
    {:ok, _} = Baz.CollectionImports.create_collection_import(attrs)

    IEx.dont_display_result()
  end

  defp build_attrs(opts) do
    venue = Keyword.fetch!(opts, :venue)
    slug = Keyword.fetch!(opts, :slug)
    {:ok, max_job_retries} = Baz.Settings.get(:max_job_retries)

    %{"venue" => venue, "slug" => slug, "max_retries" => max_job_retries}
  end
end

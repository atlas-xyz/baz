defmodule Baz.CollectionEventImports.CollectionEventImport do
  @moduledoc """
  CollectionEventImport resource
  """

  use Ecto.Schema
  import Ecto.Changeset
  alias Baz.CollectionEventImportPages.CollectionEventImportPage

  @type t :: Ecto.Schema.t()

  schema "collection_event_imports" do
    field(:venue, :string)
    field(:slug, :string)
    field(:before, :utc_datetime_usec)
    field(:after, :utc_datetime_usec)
    field(:token_ids, Baz.EctoTypes.Strings)
    field(:event_types, {:array, :string})
    field :max_retries, :integer
    field(:status, :string)
    has_many(:pages, CollectionEventImportPage)

    timestamps(type: :utc_datetime_usec)
  end

  @doc false
  def changeset(collection, attrs) do
    collection
    |> cast(attrs, [
      :venue,
      :slug,
      :before,
      :after,
      :token_ids,
      :event_types,
      :max_retries,
      :status
    ])
    |> validate_required([
      :venue,
      :slug,
      :before,
      :after,
      :max_retries,
      :status
    ])
  end
end

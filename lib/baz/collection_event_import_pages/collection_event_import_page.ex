defmodule Baz.CollectionEventImportPages.CollectionEventImportPage do
  @moduledoc """
  CollectionEventImportPage resource
  """

  use Ecto.Schema
  import Ecto.Changeset
  alias Baz.CollectionEventImports.CollectionEventImport

  @type t :: Ecto.Schema.t()

  @primary_key {:id, Ecto.UUID, autogenerate: true}
  @foreign_key_type Ecto.UUID

  schema "collection_event_import_pages" do
    field(:page_number, :integer)
    field(:next_page_cursor, :string)
    belongs_to(:collection_event_import, CollectionEventImport)

    timestamps(type: :utc_datetime_usec)
  end

  @doc false
  def changeset(page, attrs) do
    page
    |> cast(attrs, [:page_number, :next_page_cursor])
    |> cast_assoc(:collection_event_import)
    |> validate_required([:page_number, :collection_event_import])
    |> unique_constraint([:collection_event_import, :page_number])
  end
end

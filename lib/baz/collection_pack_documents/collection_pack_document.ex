defmodule Baz.CollectionPackDocuments.CollectionPackDocument do
  @moduledoc """
  CollectionPackDocument resource
  """

  @type t :: struct

  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, Ecto.UUID, autogenerate: true}

  schema "collection_pack_documents" do
    field(:language, :string)
    field(:search_vector, :string)

    belongs_to(:collection_pack, Baz.CollectionPacks.CollectionPack)

    timestamps()
  end

  @doc false
  def changeset(collection_pack_document, attrs) do
    collection_pack_document
    |> cast(attrs, [
      :language,
      :search_vector,
      :collection_pack_id,
    ])
    |> validate_required([:collection_pack_id, :language, :search_vector])
    |> unique_constraint([:collection_pack_id, :language])
  end
end

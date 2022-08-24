defmodule Baz.CollectionImports.CollectionImport do
  @moduledoc """
  CollectionImport resource
  """

  @type t :: struct

  use Ecto.Schema
  import Ecto.Changeset

  schema "collection_imports" do
    field :venue, :string
    field :slug, :string
    field :status, :string

    timestamps(type: :utc_datetime_usec)
  end

  @doc false
  def changeset(collection, attrs) do
    collection
    |> cast(attrs, [:venue, :slug, :status])
    |> validate_required([:venue, :slug, :status])
  end
end

defmodule Baz.CollectionImports.CollectionImport do
  @moduledoc """
  CollectionImport resource
  """

  use Ecto.Schema
  import Ecto.Changeset

  @type t :: struct

  @primary_key {:id, Ecto.UUID, autogenerate: true}

  schema "collection_imports" do
    field :venue, :string
    field :slug, :string
    field :max_retries, :integer
    field :status, :string

    timestamps(type: :utc_datetime_usec)
  end

  @doc false
  def changeset(collection, attrs) do
    collection
    |> cast(attrs, [:venue, :slug, :max_retries, :status])
    |> validate_required([:venue, :slug, :max_retries, :status])
  end
end

defmodule Baz.Venues.Venue do
  @moduledoc """
  Venue resource
  """

  use Ecto.Schema
  import Ecto.Changeset

  schema "venues" do
    field :name, :string
    field :adapter, EctoTerm
    field :credentials, :map
    field :collections, :string
    field :start_on_boot, :boolean
    field :poll_stream_enabled, :boolean
    field :websocket_stream_enabled, :boolean
  end

  @doc false
  def changeset(collection, attrs) do
    collection
    |> cast(attrs, [:name, :adapter, :credentials, :collections, :start_on_boot, :poll_stream_enabled, :websocket_stream_enabled])
    |> validate_required([:name, :adapter, :credentials, :collections, :start_on_boot, :poll_stream_enabled, :websocket_stream_enabled])
    |> unique_constraint(:name)
  end
end

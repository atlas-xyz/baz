defmodule Baz.VenueWebSockets.VenueWebSocket do
  @moduledoc false

  @type t :: Ecto.Schema.t()

  use Ecto.Schema
  import Ecto.Changeset

  schema "venue_web_sockets" do
    field(:venue, :string)
    field(:pid, EctoTerm)
  end

  @doc false
  def changeset(collection, attrs) do
    collection
    |> cast(attrs, [
      :venue,
      :pid
    ])
    |> validate_required([
      :venue,
      :pid
    ])
  end
end

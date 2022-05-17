defmodule Baz.Venues.Services.LoadConfig do
  alias Baz.Venues
  alias Baz.MemoryRepo

  @type error_reason :: term
  @spec call(map) :: {:ok, loaded_venues :: non_neg_integer} | {:error, error_reason}
  def call(venue_config) do
    venue_config
    |> Enum.map(fn {name, {adapter, config}} ->
      attrs = Map.merge(config, %{name: name, adapter: adapter})

      %Venues.Venue{}
      |> Venues.Venue.changeset(attrs)
      |> MemoryRepo.insert()
    end)

    # TODO: return the number of venues parsed
    {:ok, 0}
  end
end

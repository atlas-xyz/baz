defmodule Baz.Venues.Services.LoadConfig do
  alias Baz.Venues
  alias Baz.MemoryRepo

  @type load_result :: {load_success :: non_neg_integer, load_error :: non_neg_integer}
  @spec call(map) :: load_result
  def call(venue_config) do
    venue_config
    |> Enum.map(fn {name, config} ->
      attrs = Map.merge(config, %{name: name})

      %Venues.Venue{}
      |> Venues.Venue.changeset(attrs)
      |> MemoryRepo.insert()
    end)
    |> Enum.reduce(
      {0, 0},
      fn 
        {:ok, _}, {success, error} -> {success+1, error}
        {:error, _}, {success, error} -> {success, error+1}
      end
    )
  end
end

defmodule Baz.Venues do
  alias Baz.MemoryRepo
  alias Baz.Venues.Venue
  alias Baz.Venues.Queries
  alias Baz.Venues.Services

  @type where_opt :: {:where, [{atom, term}]}
  @type order_opt :: {:order, [atom]}
  @type venue :: term

  @type filter_and_order_opts :: [where_opt | order_opt]
  @spec filter_and_order(filter_and_order_opts) :: [venue]
  def filter_and_order(opts) do
    opts
    |> Queries.FilterAndOrder.new()
    |> MemoryRepo.all()
  end

  @doc """
  Gets a single venue.

  Raises `Ecto.NoResultsError` if the Venue does not exist.

  ## Examples

      iex> get_venue!("open_sea")
      %Venue{}

      iex> get_venue!("open_zea")
      ** (Ecto.NoResultsError)

  """
  @spec get_venue!(String.t()) :: term
  def get_venue!(name), do: MemoryRepo.get_by!(Venue, name: name)

  @spec load_config(map) :: {:ok, loaded_venues :: non_neg_integer} | {:error, Services.LoadConfig.error_reason()}
  def load_config(venue_config \\ Application.get_env(:baz, :venues, %{})) do
    Services.LoadConfig.call(venue_config)
  end
end

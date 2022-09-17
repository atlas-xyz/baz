defmodule Baz.VenueWebSockets do
  alias Baz.MemoryRepo
  alias Baz.VenueWebSockets.Queries
  alias Baz.VenueWebSockets.VenueWebSocket

  @type venue_web_socket :: VenueWebSocket.t()

  @type filter_and_order_opts :: [where_opt | order_opt]
  @type where_opt :: {:where, [{atom, term}]}
  @type order_opt :: {:order, [atom]}

  @doc """
  Gets venue web sockets that match the where clause sorted by the order clause.

  ## Examples

      iex> filter_and_order(where: [venue: "open_sea"], order: [desc: :venue])
      [%EventStream{}]

  """
  @spec filter_and_order(filter_and_order_opts) :: [venue_web_socket]
  def filter_and_order(opts) do
    opts
    |> Queries.FilterAndOrder.new()
    |> MemoryRepo.all()
  end

  @doc """
  Gets a single venue web socket.

  Raises `Ecto.NoResultsError` if the VenueWebSocket does not exist.

  ## Examples

      iex> get_venue_web_socket!(123)
      %Collection{}

      iex> get_venue_web_socket!(456)
      ** (Ecto.NoResultsError)

  """
  @spec get_venue_web_socket!(term) :: venue_web_socket
  def get_venue_web_socket!(id), do: MemoryRepo.get!(VenueWebSocket, id)

  @type create_attrs :: map
  @spec create_venue_web_socket(create_attrs) :: {:ok, venue_web_socket} | {:error, term}
  def create_venue_web_socket(attrs) do
    %VenueWebSocket{}
    |> VenueWebSocket.changeset(attrs)
    |> MemoryRepo.insert()
  end

  @type venue_name :: Baz.Venues.Venue.name()

  @spec start_venue_web_socket(venue_name) :: :ok
  def start_venue_web_socket(venue_name) do
    venue = Baz.Venues.get_venue!(venue_name)
    venue.adapter.start_venue_web_socket(venue)
  end

  @spec stop_venue_web_socket(venue_name) :: :ok
  def stop_venue_web_socket(venue_name) do
    venue = Baz.Venues.get_venue!(venue_name)
    venue.adapter.stop_venue_web_socket(venue)
  end

  @type slug_mask :: String.t()

  @spec subscribe_venue_web_socket(venue_name, slug_mask) :: :ok
  def subscribe_venue_web_socket(venue_name, slug_mask) do
    venue = Baz.Venues.get_venue!(venue_name)
    venue.adapter.subscribe_venue_web_socket(venue, slug_mask)
  end

  @spec unsubscribe_venue_web_socket(venue_name, slug_mask) :: :ok
  def unsubscribe_venue_web_socket(venue_name, slug_mask) do
    venue = Baz.Venues.get_venue!(venue_name)
    venue.adapter.unsubscribe_venue_web_socket(venue, slug_mask)
  end
end

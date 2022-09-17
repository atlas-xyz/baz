defmodule Baz.IEx do
  @moduledoc """
  Commands to control `baz` within an Elixir interactive shell
  """

  alias Baz.IEx.Commands

  @spec help :: no_return
  defdelegate help, to: Commands.Help

  @spec collection_packs() :: no_return
  @spec collection_packs(Commands.CollectionPacks.opts()) :: no_return
  defdelegate collection_packs(options \\ []), to: Commands.CollectionPacks, as: :filter_and_order

  @spec collections() :: no_return
  @spec collections(Commands.Collections.opts()) :: no_return
  defdelegate collections(options \\ []), to: Commands.Collections, as: :filter_and_order

  @spec collection_assets() :: no_return
  @spec collection_assets(Commands.CollectionAssets.opts()) :: no_return
  defdelegate collection_assets(options \\ []),
    to: Commands.CollectionAssets,
    as: :filter_and_order

  @spec venue_web_sockets() :: no_return
  @spec venue_web_sockets(Commands.VenueWebSockets.opts()) :: no_return
  defdelegate venue_web_sockets(options \\ []), to: Commands.VenueWebSockets, as: :filter_and_order

  @spec start_venue_web_socket() :: no_return
  @spec start_venue_web_socket(Commands.StartVenueWebSocket.opts()) :: no_return
  defdelegate start_venue_web_socket(options \\ []),
    to: Commands.StartVenueWebSocket,
    as: :start_venue_web_socket

  @spec stop_venue_web_socket() :: no_return
  @spec stop_venue_web_socket(Commands.StopVenueWebSocket.opts()) :: no_return
  defdelegate stop_venue_web_socket(options \\ []),
    to: Commands.StopVenueWebSocket,
    as: :stop_venue_web_socket

  @spec subscribe_venue_web_socket() :: no_return
  @spec subscribe_venue_web_socket(Commands.SubscribeVenueWebSocket.opts()) :: no_return
  defdelegate subscribe_venue_web_socket(options \\ []),
    to: Commands.SubscribeVenueWebSocket,
    as: :subscribe_venue_web_socket

  @spec venues() :: no_return
  @spec venues(Commands.Venues.opts()) :: no_return
  defdelegate venues(options \\ []), to: Commands.Venues, as: :filter_and_order

  @spec settings() :: no_return
  defdelegate settings(), to: Commands.Settings, as: :list

  @spec raw_sinks() :: no_return
  defdelegate raw_sinks(options \\ []), to: Commands.RawSinks, as: :filter_and_order

  @spec normalized_sinks() :: no_return
  defdelegate normalized_sinks(options \\ []), to: Commands.NormalizedSinks, as: :filter_and_order

  @spec collection_imports() :: no_return
  @spec collection_imports(Commands.CollectionImports.opts()) :: no_return
  defdelegate collection_imports(options \\ []),
    to: Commands.CollectionImports,
    as: :filter_and_order

  @spec collection_asset_imports() :: no_return
  @spec collection_asset_imports(Commands.CollectionAssetImports.opts()) :: no_return
  defdelegate collection_asset_imports(options \\ []),
    to: Commands.CollectionAssetImports,
    as: :filter_and_order

  @spec import_collection() :: no_return
  @spec import_collection(Commands.ImportCollection.opts()) :: no_return
  defdelegate import_collection(options \\ []), to: Commands.ImportCollection, as: :create

  @spec import_collection_assets() :: no_return
  @spec import_collection_assets(Commands.ImportCollectionAssets.opts()) :: no_return
  defdelegate import_collection_assets(options \\ []),
    to: Commands.ImportCollectionAssets,
    as: :create

  @spec collection_events() :: no_return
  @spec collection_events(Commands.CollectionEvents.opts()) :: no_return
  defdelegate collection_events(options \\ []),
    to: Commands.CollectionEvents,
    as: :filter_and_order

  @spec collection_event_imports() :: no_return
  @spec collection_event_imports(Commands.CollectionEventImports.opts()) :: no_return
  defdelegate collection_event_imports(options \\ []),
    to: Commands.CollectionEventImports,
    as: :filter_and_order

  @spec import_collection_events() :: no_return
  @spec import_collection_events(Commands.ImportCollectionEvents.opts()) :: no_return
  defdelegate import_collection_events(options \\ []),
    to: Commands.ImportCollectionEvents,
    as: :create
end

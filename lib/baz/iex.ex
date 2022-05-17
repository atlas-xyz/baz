defmodule Baz.IEx do
  @moduledoc """
  Commands to control `baz` within an Elixir interactive shell
  """

  alias Baz.IEx.Commands

  @spec help :: no_return
  defdelegate help, to: Commands.Help

  # @spec collection_packs() :: no_return
  # @spec collection_packs(Commands.CollectionPacks.opts()) :: no_return
  # defdelegate collection_packs(options \\ []), to: Commands.CollectionPacks, as: :filter_and_order

  @spec collections() :: no_return
  @spec collections(Commands.Collections.opts()) :: no_return
  defdelegate collections(options \\ []), to: Commands.Collections, as: :filter_and_order

  @spec venues() :: no_return
  @spec venues(Commands.Venues.opts()) :: no_return
  defdelegate venues(options \\ []), to: Commands.Venues, as: :filter_and_order

  # @spec venue_channels() :: no_return
  # @spec venue_channels(Commands.VenueChannels.opts()) :: no_return
  # defdelegate venue_channels(options \\ []), to: Commands.VenueChannels, as: :filter_and_order

  # @spec start_venue_channels() :: no_return
  # @spec start_venue_channels(Commands.StartVenueChannels.opts()) :: no_return
  # defdelegate start_venue_channels(options \\ []), to: Commands.StartVenueChannels, as: :start

  # @spec stop_venue_channels() :: no_return
  # @spec stop_venue_channels(Commands.StopVenueChannels.opts()) :: no_return
  # defdelegate stop_venue_channels(options \\ []), to: Commands.StopVenueChannels, as: :stop

  @spec collection_imports() :: no_return
  @spec collection_imports(Commands.CollectionImports.opts()) :: no_return
  defdelegate collection_imports(options \\ []), to: Commands.CollectionImports, as: :filter_and_order

  @spec import_collection() :: no_return
  @spec import_collection(Commands.ImportCollection.opts()) :: no_return
  defdelegate import_collection(options \\ []), to: Commands.ImportCollection, as: :create
end

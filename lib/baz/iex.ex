defmodule Baz.IEx do
  @moduledoc """
  Commands to control `baz` in an Elixir interactive shell
  """

  alias Baz.IEx.Commands

  @spec help :: no_return
  defdelegate help, to: Commands.Help

  @spec venues() :: no_return
  @spec venues(Commands.Venues.opts()) :: no_return
  defdelegate venues(options \\ []), to: Commands.Venues, as: :filter_and_order

  @spec start_venues() :: no_return
  @spec start_venues(Commands.StartVenues.opts()) :: no_return
  defdelegate start_venues(options \\ []), to: Commands.StartVenues, as: :start

  @spec stop_venues() :: no_return
  @spec stop_venues(Commands.StopVenues.opts()) :: no_return
  defdelegate stop_venues(options \\ []), to: Commands.StopVenues, as: :stop

  @spec collection_packs() :: no_return
  @spec collection_packs(Commands.CollectionPacks.opts()) :: no_return
  defdelegate collection_packs(options \\ []), to: Commands.CollectionPacks, as: :filter_and_order

  @spec collections() :: no_return
  @spec collections(Commands.Collections.opts()) :: no_return
  defdelegate collections(options \\ []), to: Commands.Collections, as: :filter_and_order

  @spec backfill() :: no_return
  @spec backfill(Commands.Backfill.opts()) :: no_return
  defdelegate backfill(options \\ []), to: Commands.Backfill, as: :schedule
end

defmodule Baz.VenueChannels.VenueChannel do
  @type t :: %__MODULE__{
    id: String.t(),
    credentials: map,
    status: atom,
    streams: [atom],
    timeout: non_neg_integer,
    start_on_boot: boolean
  }

  defstruct ~w[
    id
    credentials
    status
    streams
    timeout
    start_on_boot
  ]a
end

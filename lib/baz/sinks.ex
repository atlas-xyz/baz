defmodule Baz.Sinks do
  require Logger

  @type sink_type :: atom
  @type venue :: Baz.Venues.Venue.t()

  @timeout 60000

  @spec write_raw(sink_type, venue, term, term) :: term
  def write_raw(type, venue, input, api_response) do
    :poolboy.transaction(
      :sink_worker,
      fn pid ->
        try do
          GenServer.cast(pid, {:write_raw, type, venue, input, api_response})
        rescue
          e ->
            "sink poolboy transaction rescued error=~s" |> format_log_error([inspect(e)])
            :ok
        end
      end,
      @timeout
    )
  end

  defp format_log_error(format, data) do
    format
    |> :io_lib.format(data)
    |> Logger.error()
  end
end

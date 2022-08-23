defmodule Baz.RawSink do
  @type sink_type :: atom
  @type input :: term
  @type api_response :: term

  @callback receive_raw(sink_type, input, api_response) :: :ok
end

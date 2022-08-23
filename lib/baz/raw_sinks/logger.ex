defmodule Baz.RawSinks.Logger do
  require Logger

  def receive_raw(type, input, api_response) do
    "received raw sink type=~w, input=~s, api_response=~s"
    |> format_log_info([type, inspect(input), inspect(api_response)])
  end

  defp format_log_info(format, data) do
    format
    |> :io_lib.format(data)
    |> Logger.info()
  end
end

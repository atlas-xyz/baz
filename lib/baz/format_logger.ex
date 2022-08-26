defmodule Baz.FormatLogger do
  require Logger

  def log_info(format, data) do
    format
    |> :io_lib.format(data)
    |> Logger.info()
  end

  def log_warn(format, data) do
    format
    |> :io_lib.format(data)
    |> Logger.warn()
  end

  def log_error(format, data) do
    format
    |> :io_lib.format(data)
    |> Logger.error()
  end
end

defmodule Baz.IEx.Commands.Settings do
  @moduledoc """
  Render a table for the list of settings
  """

  import Baz.IEx.Output.Table, only: [render!: 2]

  defmodule Row do
    defstruct ~w[name value]a
  end

  @header [
    "Name",
    "Value"
  ]

  @spec list :: no_return
  def list do
    []
    |> build_rows()
    |> format_rows()
    |> render!(@header)
  end

  def build_rows(_opts) do
    settings = Baz.Settings.all()

    settings
    |> Enum.map(fn {name, value} ->
      %Row{name: name, value: value}
    end)
  end

  defp format_rows(rows) do
    rows
    |> Enum.map(fn r ->
      [
        r.name,
        r.value
      ]
      |> Enum.map(&format_col/1)
    end)
  end

  defp format_col(nil), do: "-"
  defp format_col([]), do: "-"
  defp format_col(val) when is_list(val), do: val |> Enum.join(", ")
  defp format_col(val), do: val
end

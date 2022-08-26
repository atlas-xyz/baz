defmodule Baz.EctoTypes.Strings do
  use Ecto.Type
  require Logger

  def type, do: {:array, :string}

  def cast(nil), do: {:ok, nil}

  def cast(str) when is_binary(str) do
    str
    |> String.replace(~r/\s/, "")
    |> String.split(",")
    |> cast
  end

  def cast(arr) when is_list(arr) do
    arr
    |> Enum.reduce(
      {:ok, []},
      fn
        "", acc ->
          acc

        v, {:ok, values} when is_integer(v) ->
          {:ok, values ++ [Integer.to_string(v)]}

        v, {:ok, values} when is_binary(v) ->
          {:ok, values ++ [v]}

        _, :error ->
          :error

        _, _ ->
          :error
      end
    )
  end

  def cast(_), do: :error

  def load(val) when is_list(val), do: {:ok, val}
  def load(_), do: :error

  def dump(val) when is_list(val), do: {:ok, val}
  def dump(_), do: :error
end

defmodule Baz.EctoTypes.Integers do
  use Ecto.Type
  require Logger

  def type, do: {:array, :integer}

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
        e, {:ok, ints} when is_integer(e) ->
          {:ok, ints ++ [e]}

        "", acc ->
          acc

        e, {:ok, ints} when is_binary(e) ->
          case Integer.parse(e) do
            {i, _} -> {:ok, ints ++ [i]}
            _ -> :error
          end

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

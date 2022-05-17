defmodule Baz.Page do
  @type cursor :: String.t() | nil
  @type t :: %__MODULE__{
    data: [struct] | [Ecto.Changeset.t()],
    next_page_cursor: cursor
  }

  defstruct ~w[data next_page_cursor]a
end

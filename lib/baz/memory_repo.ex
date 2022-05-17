defmodule Baz.MemoryRepo do
  @moduledoc """
  ETS backed in memory ecto repository for ephemeral data
  """

  use Ecto.Repo, otp_app: :baz, adapter: Etso.Adapter
end

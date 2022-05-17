defmodule Baz.Repo do
  @moduledoc """
  Postgres backed in ecto repository for persistent data
  """

  use Ecto.Repo, otp_app: :baz, adapter: Ecto.Adapters.Postgres
end

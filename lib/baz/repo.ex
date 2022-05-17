defmodule Baz.Repo do
  use Ecto.Repo,
    otp_app: :baz,
    adapter: Ecto.Adapters.Postgres
end

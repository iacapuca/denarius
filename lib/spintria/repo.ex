defmodule Spintria.Repo do
  use Ecto.Repo,
    otp_app: :spintria,
    adapter: Ecto.Adapters.Postgres
end

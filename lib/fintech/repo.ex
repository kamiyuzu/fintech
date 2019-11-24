defmodule Fintech.Repo do
  use Ecto.Repo,
    otp_app: :fintech,
    adapter: Ecto.Adapters.Postgres
end

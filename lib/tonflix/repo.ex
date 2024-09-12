defmodule Tonflix.Repo do
  use Ecto.Repo,
    otp_app: :tonflix,
    adapter: Ecto.Adapters.Postgres
end

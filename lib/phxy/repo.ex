defmodule Phxy.Repo do
  use Ecto.Repo,
    otp_app: :phxy,
    adapter: Ecto.Adapters.Postgres
end

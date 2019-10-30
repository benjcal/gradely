defmodule Gradely.Repo do
  use Ecto.Repo,
    otp_app: :gradely,
    adapter: Ecto.Adapters.Postgres
end

defmodule GameManager.Repo do
  use Ecto.Repo,
    otp_app: :game_manager,
    adapter: Ecto.Adapters.Postgres
end

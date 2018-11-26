use Mix.Config

config :game_manager, GameManager.Repo,
  database: "game_manager_test",
  username: "postgres",
  password: "postgres",
  pool: Ecto.Adapters.SQL.Sandbox

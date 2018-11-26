defmodule GameManager.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      # Starts a worker by calling: GameManager.Worker.start_link(arg)
      # {GameManager.Worker, arg},
      {GameManager.Repo, []},
      {GameManager.Manager, []}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: GameManager.Supervisor]
    Supervisor.start_link(children, opts)
  end
end

defmodule GameManager.Manager do
  use GenServer
  alias GameManager.{Metadata, Repo}

  def start_link(state) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def init(state) do
    {:ok, state}
  end

  def get_state do
    GenServer.call(__MODULE__, :get_state)
  end

  #calls
  def get_active_games do
    GenServer.call(__MODULE__, :get_active_games)
  end

  def get_completed_games do
    GenServer.call(__MODULE__, :get_completed_games)
  end

  #handlers
  def handle_call(:get_active_games, _, state) do
    games = state ++ get_all_active_games()
    {:reply, games, games}
  end

  def handle_call(:get_completed_games, _from, state) do
    {:reply, get_all_completed_games(), state}
  end

  def handle_call(:get_state, _from, state) do
    {:reply, state, state}
  end

  #private
  defp get_all_active_games do
    Metadata.all_active_games_query()
    |> Repo.all()
  end

  defp get_all_completed_games do
    Metadata.all_finished_games_query()
    |> Repo.all()
  end
end

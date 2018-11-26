defmodule GameManager do
  @moduledoc """
  Documentation for GameManager.
  """

  @doc """
  Hello world.

  ## Examples

  player_params = %{first_name: "Ladarius", last_name: "Young"}

  player2_params = %{ player_params | first_name: "Taylor"}

  player = GameManager.new_player player_params
    %GameManager.Player{
      email: "email@example.com",
      first_name: "Ladarius",
      id: any,
      last_name: "Young"
    }

  player2 = GameManager.new_player(player2_params)
    %GameManager.Player{
      email: "email@example.com",
      first_name: "Taylor",
      id: any,
      last_name: "Young"
    }

  game = GameManager.new_game player
    %GameManager.Game{
      player_1: %GameManager.Player{
        email: "email@example.com",
        first_name: "Ladarius",
        id: 0,
        last_name: "Young"
      },
      player_2: nil
    }

  GameManager.add_player game, player2
    %GameManager.Game{
      player_1: %GameManager.Player{
        email: "email@example.com",
        first_name: "Ladarius",
        id: 0,
        last_name: "Young"
      },
      player_2: %GameManager.Player{
        email: "email@example.com",
        first_name: "Taylor",
        id: 1,
        last_name: "Young"
      },
      start_time: nil
    }

  """
  alias GameManager.{Game, Metadata, Player, Repo}

  @spec new_game(%GameManager.Player{}) :: %GameManager.Game{}
  def new_game(player) do
    Game.new(player)
  end

  @spec new_player(maybe_improper_list() | map()) :: %GameManager.Player{}
  def new_player(params) do
    Player.new(params)
  end

  @spec add_player(%GameManager.Game{}, %GameManager.Player{}) :: %GameManager.Game{}
  def add_player(game, player) do
    Game.add_player(game, player)
  end

  def save_game(game) do
    game
    |> Metadata.new_game_data()
    |> Repo.insert()
  end

  def get_game(game_id) do
    game_id
    |> Metadata.single_game_query()
    |> Repo.get(limit: 1)
  end

  def all_games, do: Repo.all(Metadata)

  def all_active_games do
    Metadata.all_active_games_query()
    |> Repo.all()
  end

  def all_finished_games do
    Metadata.all_finished_games_query()
    |> Repo.all
  end

  def get_player_games(player_id) do
    player_id
    |> Metadata.player_query()
    |> Repo.all()
  end

  def get_player_recent_games(player_id, limit \\ 5) do
    player_id
    |> Metadata.recent_game_query()
    |> Repo.all(limit: limit)
  end

  def get_player_last_game(player_id, completed_status \\ false) do
    player_id
    |> Metadata.recent_game_query(completed_status)
    |> Repo.one(limit: 1)
  end

  def get_single_game(game_id) do
    game_id
    |> Metadata.single_game_query()
    |> Repo.one(limit: 1)
  end
end

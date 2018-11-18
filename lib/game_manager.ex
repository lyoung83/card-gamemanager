defmodule GameManager do
  @moduledoc """
  Documentation for GameManager.
  """

  @doc """
  Hello world.

  ## Examples

    iex> GameManager.new_player %{first_name: "Ladarius", last_name: "Young"}
    %GameManager.Player{
      email: "email@example.com",
      first_name: "Ladarius",
      id: 0,
      last_name: "Young"
    }

    iex> GameManager.new_game %GameManager.Player{email: "email@example.com",first_name: "Ladarius",id: 0,last_name: "Young"}
    %GameManager.Game{
      player_1: %GameManager.Player{
        email: "email@example.com",
        first_name: "Ladarius",
        id: 0,
        last_name: "Young"
      },
      player_2: nil
    }

    iex> GameManager.add_player %GameManager.Game{player_1: %GameManager.Player{email: "email@example.com",first_name: "Ladarius",id: 0,last_name: "Young"}, player_2: nil, start_time: nil}, %GameManager.Player{email: "email@example.com",first_name: "Ladarius",id: 1,last_name: "Young"}
    %GameManager.Game{
      player_1: %GameManager.Player{
        email: "email@example.com",
        first_name: "Ladarius",
        id: 0,
        last_name: "Young"
      },
      player_2: %GameManager.Player{
        email: "email@example.com",
        first_name: "Ladarius",
        id: 1,
        last_name: "Young"
      },
      start_time: nil
    }

  """
  alias GameManager.{Game, Player}

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

end

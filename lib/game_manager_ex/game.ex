defmodule GameManager.Game do
  defstruct [:player_1, :player_2, start_time: DateTime.utc_now(), completed: false, winner: nil]
  alias GameManager.Player

  @spec new(%GameManager.Player{}) :: %GameManager.Game{}
  def new(%Player{} = player), do: %__MODULE__{player_1: player}

  def new(_), do: raise ArgumentError, "Create a player to add to the game with the Player module first."


  def add_player(%__MODULE__{ player_1: %Player{ id: id} }, %Player{ id: id }), do: raise ArgumentError, "Cannot add the same player"

  @spec add_player(%GameManager.Game{}, %GameManager.Player{}) :: %GameManager.Game{}
  def add_player(%__MODULE__{} = game, %Player{} = player), do: %__MODULE__{ game | player_2: player}

  def add_player(_, _), do: raise ArgumentError, "Make sure you have created a game and have new player to add to the game"
end

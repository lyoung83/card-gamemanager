defmodule GameManager.Game do
  use Ecto.Schema
  import Ecto.UUID
  alias GameManager.Player

  @derive Jason.Encoder

  # defstruct [:player_1, :player_2, start_time: DateTime.utc_now(), completed: false, winner: nil, game_id: generate()]

  embedded_schema do
    field :start_time, :utc_datetime, default: DateTime.utc_now()
    field :completed, :boolean, default: false
    field :game_id, :string
    embeds_one :player_1, Player
    embeds_one :player_2, Player
  end


  @spec new(%GameManager.Player{}) :: %GameManager.Game{}
  def new(%Player{} = player), do: %__MODULE__{player_1: player, game_id: generate()}

  def new(_), do: raise ArgumentError, "Create a player to add to the game with the Player module first."


  def add_player(%__MODULE__{ player_1: %Player{ id: id} }, %Player{ id: id }), do: raise ArgumentError, "Cannot add the same player"

  def add_player(%__MODULE__{ player_1: %Player{ first_name: first_name, last_name: last_name} }, %Player{ first_name: first_name, last_name: last_name}), do: raise ArgumentError, "Cannot add player with the same first and last name"


  @spec add_player(%GameManager.Game{}, %GameManager.Player{}) :: %GameManager.Game{}
  def add_player(%__MODULE__{} = game, %Player{} = player), do: %__MODULE__{ game | player_2: player}

  def add_player(_, _), do: raise ArgumentError, "Make sure you have created a game and have new player to add to the game"
end

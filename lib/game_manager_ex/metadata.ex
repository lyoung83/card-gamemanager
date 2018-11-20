defmodule GameManager.Metadata do
  use Ecto.Schema
  import Ecto.{Changeset, Query}

  schema "metadata" do
    embeds_one :data, GameManager.Game
  end

  def changeset(struct, fields \\ %{}) do
    struct
    |> change(fields)
    |> cast_embed(:data, with: &data_changeset/2)
    |> validate_required([:data])
  end

  def data_changeset(struct, fields) do
    struct
    |> cast(fields, [:completed, :game_id, :start_time, :winner])
    |> cast_embed(:player_1, with: &player_changeset/2)
    |> cast_embed(:player_2, with: &player_changeset/2)
  end

  def player_changeset(struct, fields) do
    struct
    |> cast(fields, [:email, :first_name, :last_name, :id])
  end


  @spec single_game_query(any()) :: Ecto.Query.t()
  def single_game_query(game_id) do
    from m in __MODULE__,
    where: fragment("data->>'game_id' = ?", ^game_id)
  end

  @spec player_query(any()) :: Ecto.Query.t()
  def player_query(player_id) do
    from m in __MODULE__,
    where: fragment("data->'player_1'->>'id' = ?", ^to_string(player_id)) or
     fragment("data->'player_2'->>'id' = ?", ^to_string(player_id))
  end

  @spec recent_game_query(any(), any()) :: Ecto.Query.t()
  def recent_game_query(player_id, status\\ false) do
    player_id
    |> player_query()
    |> where([_m], fragment("data->>'completed' = ?", ^to_string(status)))
    |> order_by([_m], fragment("data->>'start_time' DESC"))
  end

  def all_active_games_query do
    from m in __MODULE__,
    where: fragment("data ->>'completed' = 'false'") or
    fragment("data ->>'completed' is null")
  end

  def all_finished_games_query do
    from m in __MODULE__,
    where: fragment("data ->>'completed' = 'true'")
  end

  def player1_wins_query do
    from m in __MODULE__,
    where: fragment("data ->>'winner'")
  end

  def new_game_data(%GameManager.Game{} = game) do
    %__MODULE__{}
    |> changeset(%{data: game})
  end
end

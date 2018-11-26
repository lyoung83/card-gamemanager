defmodule GameManagerTest do
  use ExUnit.Case, async: true
  doctest GameManager

  setup do
    # Explicitly get a connection before each test
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(GameManager.Repo)
  end

  @player_params %{first_name: "Ladarius", last_name: "Young"}
  @player_params_list [first_name: "John", last_name: "Young"]
  @default_player %GameManager.Player{
    email: "email@example.com",
    first_name: "Default",
    last_name: "Default"
  }
  @completed_player_1 GameManager.Player.new(@player_params)
  @completed_player_2 GameManager.Player.new(@player_params_list)
  @new_game GameManager.new_game(@completed_player_1)
  @game @completed_player_1
        |> GameManager.new_game()
        |> GameManager.add_player(@completed_player_2)

  test "Creates New Player with Map" do
    assert GameManager.new_player(@player_params) |> Map.has_key?(:id)
  end

  test "Creates new player with list" do
    assert GameManager.new_player(@player_params_list) |> Map.has_key?(:id)
  end

  test "Creates New Game" do
    new_game = GameManager.new_game(@completed_player_1)
    assert new_game.player_1 == @completed_player_1
  end

  test "Adds New Player" do
    new_game = GameManager.add_player(@new_game, @completed_player_2)
    assert new_game.player_2 == @completed_player_2
  end

  test "Creates default player" do
    assert GameManager.new_player([]) |> Map.has_key?(:id)
  end

  test "Won't create player without collectable" do
    assert_raise ArgumentError, fn -> GameManager.new_player("params") end
  end

  test "Won't create game without player struct" do
    assert_raise ArgumentError, fn -> GameManager.new_game("player") end
  end

  test "Won't add player without game" do
    assert_raise ArgumentError, fn -> GameManager.add_player("game", @default_player) end
  end

  test "Won't add player without player struct" do
    assert_raise ArgumentError, fn -> GameManager.add_player(@new_game, "player") end
  end

  test "Won't add player same player" do
    assert_raise ArgumentError, fn -> GameManager.add_player(@new_game, @completed_player_1) end
  end

  test "Saves game as metadata" do
    assert GameManager.save_game(@game) |> (fn {_k, v} -> is_integer(v.id) end).()
  end

  test "Will only use game struct as save data" do
    assert_raise ArgumentError, fn -> GameManager.save_game(@completed_player_1) end
  end
end

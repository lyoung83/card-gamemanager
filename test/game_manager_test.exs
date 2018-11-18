defmodule GameManagerTest do
  use ExUnit.Case
  doctest GameManager

  @player_params %{first_name: "Ladarius", last_name: "Young", id: 1}
  @player_params_list [first_name: "Ladarius", last_name: "Young", id: 2]
  @default_player %GameManager.Player{email: "email@example.com", first_name: "Defualt", id: 0, last_name: "Default"}
  @completed_player_1 %GameManager.Player{email: "email@example.com", first_name: "Ladarius", id: 1, last_name: "Young"}
  @completed_player_2 %GameManager.Player{email: "email@example.com", first_name: "Ladarius", id: 2, last_name: "Young"}
  @new_game GameManager.new_game(@completed_player_1)

  test "Creates New Player with Map" do
    assert GameManager.new_player(@player_params) == @completed_player_1
  end

  test "Creates new player with list" do
    assert GameManager.new_player(@player_params_list) == @completed_player_2
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
    assert GameManager.new_player([]) == @default_player
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
end

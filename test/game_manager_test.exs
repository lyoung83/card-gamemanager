defmodule GameManagerTest do
  use ExUnit.Case
  doctest GameManager

  @player_params %{first_name: "Ladarius", last_name: "Young"}
  @player_params_list [first_name: "John", last_name: "Young"]
  @default_player %GameManager.Player{email: "email@example.com", first_name: "Default", last_name: "Default"}
  @completed_player_1 GameManager.Player.new(@player_params)
  @completed_player_2 GameManager.Player.new(@player_params_list)
  @new_game GameManager.new_game(@completed_player_1)

  test "Creates New Player with Map" do
    assert GameManager.new_player(@player_params).first_name == @completed_player_1.first_name
  end

  test "Creates new player with list" do
    assert GameManager.new_player(@player_params_list).first_name == @completed_player_2.first_name
  end

  test "Creates New Game" do
    new_game = GameManager.new_game(@completed_player_1)
    assert new_game.player_1.first_name == @completed_player_1.first_name
  end

  test "Adds New Player" do
    new_game = GameManager.add_player(@new_game, @completed_player_2)
    assert new_game.player_2.first_name == @completed_player_2.first_name
  end

  test "Creates default player" do
    assert GameManager.new_player([]).last_name == @default_player.last_name
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

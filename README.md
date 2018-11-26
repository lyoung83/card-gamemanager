# GameManager

This demo app works will work with the [game-server](https://github.com/lyoun83/game-server) to create and manage card games.

### API Usage
So far the tested API looks like this

```
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
```


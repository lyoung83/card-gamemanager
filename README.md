# GameManager

This demo app works will work with the [game-server](https://github.com/lyoun83/game-server) to create and manage card games.

### API Usage
So far the tested API looks like this

```
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
```


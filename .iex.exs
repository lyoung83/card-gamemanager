alias GameManager.{Game, Player, Repo, Metadata, Manager}

player_params = %{first_name: "Ladarius", last_name: "Young"}

player = Player.new player_params

player2 = Player.new(%{player_params | first_name: "Tay"})

defimpl Collectable, for: GameManager.Player do
  def into(attr) do
    mapper = fn
      player_map, {:cont, {k, v}} -> Map.put(player_map, k, v)
      player_map, :done -> player_map
      _player_map, :halt -> :ok
    end

    {attr, mapper}
  end
end

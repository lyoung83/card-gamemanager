defmodule GameManager.Player do
  defstruct [:first_name, :last_name, :id, :email]

  @player_defaults [first_name: "Defualt", last_name: "Default", id: 0, email: "email@example.com"]

  @spec new(maybe_improper_list() | map()) :: %__MODULE__{}
  def new(player_params) when is_list(player_params) do
    player_params
    |> overwrite_defaults()
    |> Enum.into(%__MODULE__{})
  end

  def new(player_params) when is_map(player_params), do: new Map.to_list(player_params)

  def new(_), do: raise ArgumentError, "Create player with a list or a map of :first_name, :last_name, :id, :email"

  defp overwrite_defaults(player_options) when is_list(player_options) do
     @player_defaults
     |> Keyword.merge(atomize_keys(player_options))
     |> Map.new()
  end
  defp atomize_keys(player_options), do: Enum.map(player_options, fn {k, v} -> {check_key(k), v} end)

  defp check_key(key) do
      case is_atom(key) do
        true -> key
        _ -> String.to_atom(key)
      end
  end
end

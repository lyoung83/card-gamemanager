defmodule GameManager.Player do
  use Ecto.Schema
  import Ecto.UUID
  @derive Jason.Encoder
  # defstruct [:first_name, :last_name, :id, :email]
  @primary_key {:id, :binary_id, autogenerate: generate()}
  embedded_schema do
    field :first_name, :string
    field :last_name, :string
    field :email, :string
  end

  @player_defaults [first_name: "Defualt", last_name: "Default", email: "email@example.com"]

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
     |> generate_id()
     |> Map.new()
  end
  defp atomize_keys(player_options), do: Enum.map(player_options, fn {k, v} -> {check_key(k), v} end)

  defp check_key(key) do
      case is_atom(key) do
        true -> key
        _ -> String.to_atom(key)
      end
  end

  defp generate_id(options), do: options ++ [id: generate()]
end

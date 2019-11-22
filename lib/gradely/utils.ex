defmodule Gradely.Utils do

  def keys_to_atoms(map) when is_map(map) do
    map
    |> Enum.map(fn ({k, v}) -> {str_to_atom(k), v} end)
    |> Enum.into(%{})
  end

  defp str_to_atom(str) when is_binary(str) do
    str
    |> String.downcase
    |> String.replace(" ", "_")
    |> String.to_atom
  end

  defp str_to_atom(str), do: str

end

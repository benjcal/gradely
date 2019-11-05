defmodule Gradely.Utils do


  def keys_to_atoms(map) when is_map(map) do
    map
    |> Enum.map(fn ({k, v}) -> {str_to_atom(k), v} end)
    |> Enum.into(%{})
  end

  defp str_to_atom(str) do
    if String.valid?(str) do
      String.to_atom(str)
    else
      str
    end
  end

end
defmodule Gradely.Utils do

  def ensure_atom_keys(map) when is_map(map) do
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

  def maybe_put_assoc(%Ecto.Changeset{} = changeset, _, nil), do: changeset

  def maybe_put_assoc(%Ecto.Changeset{} = changeset, key, attrs) when is_atom(key) do
      Ecto.Changeset.put_assoc(changeset, key, attrs[key])
  end

end

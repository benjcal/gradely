defmodule Gradely.Grades do
  import Ecto.Query, warn: false
  alias Gradely.Repo

  alias Gradely.Grades.Grade
  import Gradely.Utils

  def grade(attrs \\ %{}) do
    student_id = String.to_integer(attrs["student_id"], 10)
    activity_id = String.to_integer(attrs["activity_id"], 10)

    attrs = %{attrs | "value" => resolve_value(attrs["value"])}
    #attrs = %{attrs | "value" => "42"}

    grade =
      Grade
      |> where([g], g.student_id == ^student_id)
      |> where([g], g.activity_id == ^activity_id)
      |> Repo.one

    case grade do
      nil ->
        %Grade{}
        |> Grade.changeset(attrs)
        |> Repo.insert()
      grade ->
        grade
        |> Grade.changeset(attrs)
        |> Repo.update
    end

    {:ok, nil}
  end

  def resolve_value(value) do
    if has_operator(value) do
      case get_vals(value) do
        {:add, l, r} -> l + r
        {:sub, l, r} -> l - r
      end
    else
        value
    end
  end


  defp get_vals(str) do
    if String.contains?(str, "+") do
      l =
        str
        |> String.split("+")
        |> Enum.at(0)
        |> String.trim
        |> Float.parse
        |> elem(0)
      r =
        str
        |> String.split("+")
        |> Enum.at(1)
        |> String.trim
        |> Float.parse
        |> elem(0)
      {:add, l, r}
    else
      l =
        str
        |> String.split("-")
        |> Enum.at(0)
        |> String.trim
        |> Float.parse
        |> elem(0)
      r =
        str
        |> String.split("-")
        |> Enum.at(1)
        |> String.trim
        |> Float.parse
        |> elem(0)
      {:sub, l, r}
    end
  end

  defp has_operator(str) do
    String.contains?(str, "+") or
    String.contains?(str, "-")
  end

end

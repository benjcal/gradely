defmodule Gradely.Grades do
  import Ecto.Query, warn: false
  alias Gradely.Repo

  alias Gradely.Grades.Grade
  import Gradely.Utils

  def grade(attrs \\ %{}) do
    student_id = String.to_integer(attrs["student_id"], 10)
    activity_id = String.to_integer(attrs["activity_id"], 10)
    activity_total = elem(Float.parse(attrs["activity_total"]), 0)

    attrs = %{attrs | "value" => resolve_value(attrs["value"], activity_total)}

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

  def resolve_value(value, total) do
    if has_operator(value) do
      case get_vals(value, total) do
        {:add, l, r} -> l + r
        {:sub, l, r} -> l - r
      end
    else
        case has_percent(value) do
          true -> resolve_percent(value, total)
          false -> value
        end
    end
  end


  defp get_vals(str, total) do
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
        |> resolve_percent(total)
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
        |> resolve_percent(total)
      {:sub, l, r}
    end
  end

  defp has_operator(str) do
    String.contains?(str, "+") or
    String.contains?(str, "-")
  end


  defp has_percent(str) do
    String.contains?(str, "%")
  end

  defp resolve_percent(value, total) do
    if has_percent(value) do
      value = value
                |> String.replace("%", "")
                |> String.trim
                |> Float.parse()
                |> elem(0)

      (total * value) / 100
    else
        if is_bitstring(value) do
          value
          |> Float.parse
          |> elem(0)
        else
          value
        end
    end
  end

end

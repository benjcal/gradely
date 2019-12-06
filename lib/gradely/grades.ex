defmodule Gradely.Grades do
  import Ecto.Query, warn: false
  alias Gradely.Repo

  alias Gradely.Grades.Grade
  import Gradely.Utils

  def grade(attrs \\ %{}) do
    student_id = String.to_integer(attrs["student_id"], 10)
    activity_id = String.to_integer(attrs["activity_id"], 10)
    #value = String.to_float(attrs["value"])

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

end

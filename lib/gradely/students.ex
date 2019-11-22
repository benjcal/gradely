defmodule Gradely.Students do
  import Ecto.Query, warn: false
  import Ecto.Changeset
  alias Gradely.Repo
  alias Gradely.Users
  alias Gradely.Courses


  alias Gradely.Students.Student

  def get_table_page(user_id, params) do

    sort = case params["sort"] do
      "name" -> :first_name
      _ -> :id
    end

    # Users.update_preferences(conn.assigns.current_user, %{student_table_sort: "name"})

    Student
    |> order_by(asc: ^sort)
    |> where([s], s.user_id == ^user_id)
    |> preload(:courses)
    |> preload([courses: :activities])
    |> preload([courses: [activities: :grade]])
    |> Repo.paginate(params)
  end

  def get_student!(id) do
    Repo.get!(Student, id)
    |> Repo.preload(:courses)
    |> Repo.preload([courses: :activities])
    |> Repo.preload([courses: [activities: :grade]])
  end

  def get_student_clean!(id), do: Repo.get!(Student, id)

  def create(attrs \\ %{}) do
    courses = if attrs[:courses], do: Gra
    %Student{}
    |> Student.changeset(attrs[:student])
    |> put_assoc(:user, attrs[:user])
    |> put_assoc(:courses, attrs[:courses])
    |> Repo.insert()
  end

  def update(attrs \\ %{}) do
    attrs[:student]
    |> Student.changeset(attrs[:updates])
    |> put_assoc(:courses, attrs[:courses])
    |> Repo.update()
  end

  def delete_student(%Student{} = student) do
    Repo.delete(student)
  end

  def change_student(%Student{} = student) do
    Student.changeset(student, %{})
  end
end

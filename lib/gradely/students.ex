defmodule Gradely.Students do
  import Ecto.Query, warn: false
  alias Gradely.Repo

  alias Gradely.Students.Student

  def get_page(conn, params) do
    user_id = conn.assigns.current_user.id

    sort = case params["sort"] do
      "name" -> :first_name
      _ -> :id
    end

    Student
    |> order_by(asc: ^sort)
    |> where([s], s.user_id == ^user_id)
    |> Repo.paginate(params)
  end

  def get_student!(id) do
    Repo.get!(Student, id)
    |> Repo.preload(:courses)
  end

  def get_student_clean!(id), do: Repo.get!(Student, id)

  def create_student_enroll(attrs \\ %{}, courses) do
    %Student{}
    |> Student.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:courses, courses)
    |> Repo.insert()
  end

  def create_student(attrs \\ %{}) do
    %Student{}
    |> Student.changeset(attrs)
    |> Repo.insert()
  end

  def update_student(%Student{} = student, attrs) do
    student
    |> Student.changeset_edit(attrs)
    |> Repo.update()
  end

  def delete_student(%Student{} = student) do
    Repo.delete(student)
  end

  def change_student(%Student{} = student) do
    Student.changeset_edit(student, %{})
  end
end

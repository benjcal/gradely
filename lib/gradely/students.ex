defmodule Gradely.Students do
  import Ecto.Query, warn: false
  import Ecto.Changeset
  alias Gradely.Repo

  alias Gradely.Students.Student
  alias Gradely.Users
  alias Gradely.CoursesUsers.CourseUser
  alias Gradely.CourseStudent
  alias Gradely.Courses.Course

  def get_table_page(user, params) do
    user = user
           |> Repo.preload(:organization)


    sort = case params["sort"] do
      "name" -> :first_name
      _ -> :id
    end

    course_ids = CourseUser
         |> join(:inner, [c], c in assoc(c, :course))
         |> where([cu], cu.user_id == ^user.id)
         |> Repo.all
         |> Enum.map(fn cu -> cu.course_id end)

    case Users.is_admin(user) do
      true ->
        Student
        |> order_by(asc: ^sort)
        |> where([s], s.organization_id == ^user.organization.id)
        |> preload(:courses)
        |> preload([courses: :activities])
        |> preload([courses: [activities: :grade]])
        |> Repo.paginate(params)
      false ->
        Student
        |> join(:inner, [s], e in CourseStudent, on: s.id == e.student_id)
        |> where([_, e], e.course_id in ^course_ids)
        |> distinct([s], s.id)
        |> preload(:courses)
        |> preload([courses: :activities])
        |> preload([courses: [activities: :grade]])
        |> Repo.paginate(params)
    end
  end

  def get_student!(id) do
    Repo.get!(Student, id)
    |> Repo.preload(:courses)
    |> Repo.preload([courses: :activities])
    |> Repo.preload([courses: [activities: :grade]])
  end

  def get_student_clean!(id), do: Repo.get!(Student, id)

  def by_user(user_id) when is_integer(user_id) do
    Student
    |> where([s], s.user_id == ^user_id)
    |> Repo.all
    |> Repo.preload(:courses)
    |> Repo.preload([courses: :activities])
    |> Repo.preload([courses: [activities: :grade]])
  end

  def create(attrs \\ %{}) do
    %Student{}
    |> Student.changeset(attrs[:student])
    |> put_assoc(:organization, attrs[:organization])
    #|> maybe_put_assoc(:courses, attrs[:courses])
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

  def add_course(%Student{} = student, %Course{} = course) do
    student = Repo.preload(student, :courses)

    if Enum.member?(student.courses, course) do
      student
    else
      student
      |> Ecto.Changeset.change
      |> Ecto.Changeset.put_assoc(:courses, [course | student.courses])
      |> Repo.update!
    end
  end

  def add_courses(%Student{} = student, courses) do
    student = Repo.preload(student, :courses)
    courses_to_add = Enum.filter(courses, fn c -> !Enum.member?(student.courses, c) end)

      student
      |> Ecto.Changeset.change
      |> Ecto.Changeset.put_assoc(:courses, courses_to_add ++ student.courses)
      |> Repo.update!
  end


end

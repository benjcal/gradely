defmodule Gradely.Courses do
  @moduledoc """
  The Courses context.
  """

  import Ecto.Query, warn: false
  import Ecto.Changeset
  alias Gradely.Repo

  alias Gradely.Courses.Course
  alias Gradely.Users
  alias Gradely.Users.User
  alias Gradely.Students.Student
  alias Gradely.CoursesUsers.CourseUser

  def get_table_page(user, params) do
    user = user
           |> Repo.preload(:organization)

    sort = case params["sort"] do
      "name" -> :name
      _ -> :id
    end

    course_ids = CourseUser
         |> join(:inner, [c], c in assoc(c, :course))
         |> where([cu], cu.user_id == ^user.id)
         |> Repo.all
         |> Enum.map(fn cu -> cu.course_id end)

    case Users.is_admin(user) do
      true ->
        Course
        |> where([c], c.organization_id == ^user.organization.id)
        |> order_by(asc: ^sort)
        |> Repo.paginate(params)
      false ->
        Course
        |> where([c], c.id in ^course_ids)
        |> Repo.paginate(params)
    end
  end

  def get_by_organization_id(organization_id) when is_integer(organization_id) do
    Course
    |> where([c], c.organization_id == ^organization_id)
    |> Repo.all
  end

  def get_by_ids(ids) do
    Course
    |> where([c], c.id in ^ids)
    |> Repo.all
  end

  def get_course!(id) do
    Repo.get!(Course, id)
  end

  def create(attrs \\ %{}) do
    %Course{}
    |> Course.changeset(attrs[:course])
    |> put_assoc(:organization, attrs[:organization])
    |> Repo.insert()
  end

  def update_course(%Course{} = course, attrs) do
    course
    |> Course.changeset(attrs)
    |> Repo.update()
  end

  def delete_course(%Course{} = course) do
    Repo.delete(course)
  end

  def change_course(%Course{} = course) do
    Course.changeset(course, %{})
  end

  def add_user(%Course{} = course, %User{} = user) do

  end

  def add_student(%Course{} = course, %Student{} = student) do
    course = Repo.preload(course, :students)

    if Enum.member?(course.students, student) do
      course
    else
      course
      |> Ecto.Changeset.change
      |> Ecto.Changeset.put_assoc(:students, [student | course.students])
      |> Repo.update!
    end
  end

  def add_students(%Course{} = course, students) do
    course = Repo.preload(course, :students)

    students_to_add = Enum.filter(students, fn s -> !Enum.member?(course.students, s) end)

    course
    |> Ecto.Changeset.change
    |> Ecto.Changeset.put_assoc(:students, students_to_add ++ course.students)
    |> Repo.update!
  end

  defp clean_params(params) do
    case params do
      nil -> []
      _ -> params
          |> Enum.filter(fn e -> {_k, v} = e; v == "on" end)
          |> Enum.map(fn e -> {k, _v} = e; String.to_integer(k) end)
    end
  end

  def get_from_params(params) do
    params
    |> clean_params
    |> get_by_ids
  end
end

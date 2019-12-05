defmodule Gradely.Courses do
  @moduledoc """
  The Courses context.
  """

  import Ecto.Query, warn: false
  import Ecto.Changeset
  alias Gradely.Repo

  alias Gradely.Courses.Course
  alias Gradely.Users
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
    |> get_courses
  end
end

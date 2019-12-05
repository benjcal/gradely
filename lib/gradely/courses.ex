defmodule Gradely.Courses do
  @moduledoc """
  The Courses context.
  """

  import Ecto.Query, warn: false
  import Ecto.Changeset
  alias Gradely.Repo

  alias Gradely.Courses.Course

  def by_user(user_id) when is_integer(user_id) do
    Course
    |> where([c], c.user_id == ^user_id)
    |> Repo.all
  end

  def list_courses(conn) do
    user_id = conn.assigns.current_user.id

    Course
    |> where([c], c.user_id == ^user_id)
    |> Repo.all
  end

  def get_courses(ids) do
    Course
    |> where([c], c.id in ^ids)
    |> Repo.all
  end

  def get_page(conn, params) do
    user_id = conn.assigns.current_user.id

    sort = case params["sort"] do
      "name" -> :name
      _ -> :id
    end

    Course
    |> order_by(asc: ^sort)
    |> where([s], s.user_id == ^user_id)
    |> Repo.paginate(params)
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

  def create_course(attrs \\ %{}) do
    %Course{}
    |> Course.changeset(attrs)
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

  def clean_params(params) do
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

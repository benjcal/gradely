defmodule GradelyWeb.ActivityController do
  use GradelyWeb, :controller

  alias Gradely.Activities
  alias Gradely.Activities.Activity
  alias Gradely.Courses

  def index(conn, _params) do
    activities = Activities.list_activities()
    render(conn, "index.html", activities: activities)
  end

  def new(conn, params) do
    course = Gradely.Courses.get_course!(params["course_id"])
    changeset = Activities.change_activity(%Activity{})
    render(conn,
      "new.html",
      changeset: changeset,
      course: course
    )
  end

  def create(conn, params) do
    course = Courses.get_course!(params["course_id"])
    attrs = %{
      user: get_user(conn),
      course: course,
      activity: params["activity"]
    }

    case Activities.create(attrs) do
      {:ok, _activity} ->
        conn
        |> put_flash(:info, "Activity created successfully.")
        |> redirect(to: Routes.course_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html",
        changeset: changeset,
        course: course
        )
    end
  end

  def show(conn, %{"id" => id}) do
    activity = Activities.get_activity!(id)
    render(conn, "show.html", activity: activity)
  end

  def edit(conn, %{"id" => id}) do
    activity = Activities.get_activity!(id)
    changeset = Activities.change_activity(activity)
    render(conn, "edit.html", activity: activity, changeset: changeset)
  end

  def update(conn, %{"id" => id, "activity" => activity_params}) do
    activity = Activities.get_activity!(id)

    case Activities.update_activity(activity, activity_params) do
      {:ok, activity} ->
        conn
        |> put_flash(:info, "Activity updated successfully.")
        |> redirect(to: Routes.course_activity_path(conn, :show, activity))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", activity: activity, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    activity = Activities.get_activity!(id)
    {:ok, _activity} = Activities.delete_activity(activity)

    conn
    |> put_flash(:info, "Activity deleted successfully.")
    # |> redirect(to: Routes.course_activity_path(conn, :index))
  end
end

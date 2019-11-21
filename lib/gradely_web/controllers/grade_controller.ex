defmodule GradelyWeb.GradeController do
  use GradelyWeb, :controller

  alias Gradely.Grades
  alias Gradely.Grades.Grade

  def index(conn, _params) do
    grades = Grades.list_grades()
    render(conn, "index.html", grades: grades)
  end

  def new(conn, _params) do
    changeset = Grades.change_grade(%Grade{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, params) do
    %{"grade" => grade_params} = params
    case Grades.create_grade(grade_params) do
      {:ok, grade} ->
        conn
        |> put_flash(:info, "Grade created successfully.")
        |> redirect(to: Routes.student_path(conn, :show, grade_params["student_id"]))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    grade = Grades.get_grade!(id)
    render(conn, "show.html", grade: grade)
  end

  def edit(conn, params) do
    %{"id" => id} = params
    IO.inspect params
    grade = Grades.get_grade!(id)
    changeset = Grades.change_grade(grade)
    render(conn, "edit.html", grade: grade, changeset: changeset)
  end

  def update(conn, %{"id" => id, "grade" => grade_params}) do
    grade = Grades.get_grade!(id)

    case Grades.update_grade(grade, grade_params) do
      {:ok, grade} ->
        conn
        |> put_flash(:info, "Grade updated successfully.")
        |> redirect(to: Routes.student_path(conn, :show, grade_params["student_id"]))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", grade: grade, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    grade = Grades.get_grade!(id)
    {:ok, _grade} = Grades.delete_grade(grade)

    conn
    |> put_flash(:info, "Grade deleted successfully.")
    |> redirect(to: Routes.grade_path(conn, :index))
  end
end

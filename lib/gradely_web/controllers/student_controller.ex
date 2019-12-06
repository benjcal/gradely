defmodule GradelyWeb.StudentController do
  use GradelyWeb, :controller

  alias Gradely.Students
  alias Gradely.Students.Student
  alias Gradely.Courses

  def index(conn, params) do
    page = Students.get_table_page(get_user(conn), params)

    render(conn, "index.html",
      students: page.entries,
      page_number: page.page_number,
      page_size: page.page_size,
      total_pages: page.total_pages,
      total_entries: page.total_entries
    )
  end

  def new(conn, _params) do
    changeset = Students.change_student(%Student{})

    render(conn, "new.html",
      changeset: changeset,
      courses: Courses.get_by_organization_id(get_organization_id(conn))
    )
  end

  def create(conn, params) do
    attrs = %{
      organization: get_organization(conn),
      student: params["student"],
      courses: Courses.get_from_params(params["courses"])
    }

    case Students.create(attrs) do
      {:ok, _student} ->
        conn
        |> put_flash(:info, "Student created successfully.")
        |> redirect(to: Routes.student_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html",
          changeset: changeset,
          courses: Courses.by_user(get_user_id(conn))
        )
    end
  end

  def show(conn, %{"id" => id}) do
    student = Students.get_student!(id)
    IO.inspect student

    render(conn, "show.html", student: student)
  end

  def edit(conn, %{"id" => id}) do
    student = Students.get_student!(id)
    changeset = Students.change_student(student)

    render(conn, "edit.html",
      student: student,
      changeset: changeset,
      courses: Gradely.Courses.by_user(get_user_id(conn))
    )
  end

  def update(conn, params) do
    student = Students.get_student!(params["id"])

    attrs = %{
      student: student,
      courses: Courses.get_from_params(params["courses"]),
      updates: params["student"]
    }

    case Students.update(attrs) do
      {:ok, _student} ->
        conn
        |> put_flash(:info, "Student updated successfully.")
        |> redirect(to: Routes.student_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html",
        student: student,
        changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    student = Students.get_student_clean!(id)
    {:ok, _student} = Students.delete_student(student)

    conn
    |> put_flash(:info, "Student deleted successfully.")
    |> redirect(to: Routes.student_path(conn, :index))
  end
end

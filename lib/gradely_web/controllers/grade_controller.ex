defmodule GradelyWeb.GradeController do
  use GradelyWeb, :controller

  alias Gradely.Grades
  alias Gradely.Grades.Grade

  def grade(conn, params) do
    %{"grade" => grade_params} = params


    case Grades.grade(grade_params) do
      {:ok, grade} ->
        conn
        |> redirect(to: Routes.student_path(conn, :show, grade_params["student_id"]))

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> redirect(to: Routes.student_path(conn, :show, grade_params["student_id"]))
    end

    #%{"grade" => grade_params} = params
    #case Grades.grade(grade_params) do
      #{:ok, grade} ->
        #conn
        #|> redirect(to: Routes.student_path(conn, :show, grade_params["student_id"]))

      #{:error, %Ecto.Changeset{} = changeset} ->
        #render(conn, "new.html", changeset: changeset)
    #end
  end

end

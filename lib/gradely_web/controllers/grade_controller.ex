defmodule GradelyWeb.GradeController do
  use GradelyWeb, :controller

  alias Gradely.Grades
  alias Gradely.Grades.Grade

  def grade(conn, params) do
    %{"grade" => grade_params} = params

    late =
      case grade_params["late"] do
        nil -> false
        "on" -> true
      end
    
    missing =
      case grade_params["missing"] do
        nil -> false
        "on" -> true
      end

   grade_params = Map.put(grade_params, "late", late) 
   grade_params = Map.put(grade_params, "missing", missing) 

    case Grades.grade(grade_params) do
      {:ok, grade} ->
        conn
        |> redirect(to: Routes.student_path(conn, :show, grade_params["student_id"]))

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> redirect(to: Routes.student_path(conn, :show, grade_params["student_id"]))
    end

  end

end

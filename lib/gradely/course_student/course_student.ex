defmodule Gradely.Courses.CourseStudent do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  schema "course_student" do
    belongs_to :course, Gradely.Courses.Course
    belongs_to :student, Gradely.Students.Student

    timestamps()
  end

  @doc false
  def changeset(course_sudent, attrs) do
    course_sudent
    |> validate_required([])
  end
end

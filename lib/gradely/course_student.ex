defmodule Gradely.CourseStudent do
  use Ecto.Schema
  import Ecto.Changeset

  schema "courses_students" do
    belongs_to :courses, Gradely.Courses.Course
    belongs_to :students, Gradely.Students.Student

    timestamps()
  end

  @doc false
  def changeset(course_student, attrs) do
    course_student
    |> cast(attrs, [])
    |> validate_required([])
  end
end

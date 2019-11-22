defmodule Gradely.Enrollments.Enrollment do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  schema "enrollments" do
    belongs_to :course, Gradely.Courses.Course
    belongs_to :student, Gradely.Students.Student

    timestamps()
  end

  @doc false
  def changeset(enrollment, attrs) do
    enrollment
    |> put_assoc(:course, attrs.course)
    |> put_assoc(:course, attrs.student)
    |> validate_required([])
  end
end

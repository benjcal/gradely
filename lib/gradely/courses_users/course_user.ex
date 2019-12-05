defmodule Gradely.CoursesUsers.CourseUser do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  schema "courses_users" do
    belongs_to :course, Gradely.Courses.Course
    belongs_to :user, Gradely.Users.User

    timestamps()
  end

  @doc false
  def changeset(enrollment, attrs) do
    enrollment
    |> validate_required([])
  end
end

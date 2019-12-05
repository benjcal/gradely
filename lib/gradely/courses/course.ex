defmodule Gradely.Courses.Course do
  use Ecto.Schema
  import Ecto.Changeset

  schema "courses" do
    belongs_to :organization, Gradely.Organizations.Organization

    field :name, :string
    many_to_many :students, Gradely.Students.Student,
      join_through: Gradely.Enrollments.Enrollment

    many_to_many :users, Gradely.Users.User,
      join_through: Gradely.CoursesUsers.CourseUser

    has_many :activities, Gradely.Activities.Activity

    timestamps()
  end

  @doc false
  def changeset(course, attrs) do
    attrs = Gradely.Utils.ensure_atom_keys(attrs)
    course
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end

end

defmodule Gradely.Students.Student do
  use Ecto.Schema
  import Ecto.Changeset

  schema "students" do
    belongs_to :user, Gradely.Users.User

    field :first_name, :string
    field :last_name, :string

    many_to_many :courses, Gradely.Courses.Course,
      join_through: Gradely.Enrollments.Enrollment, on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(student, attrs) do
    student
    |> cast(attrs, [:first_name, :last_name])
    |> validate_required([:first_name, :last_name])
  end

end

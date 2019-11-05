defmodule Gradely.Students.Student do
  use Ecto.Schema
  import Ecto.Changeset

  schema "students" do
    belongs_to :user, Gradely.Users.User

    field :number, :string
    field :first_name, :string
    field :last_name, :string
    many_to_many :courses, Gradely.Courses.Course,
      join_through: Gradely.Enrollments.Enrollment

    timestamps()
  end

  @doc false
  def changeset(student, attrs) do
    attrs = Gradely.Utils.keys_to_atoms(attrs)
    student
    |> cast(attrs, [:number, :first_name, :last_name])
    |> put_assoc(:user, Map.get(attrs, :user))
    |> put_assoc(:courses, Map.get(attrs, :courses, []))
    |> validate_required([:first_name, :last_name])
  end
end

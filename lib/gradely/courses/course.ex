defmodule Gradely.Courses.Course do
  use Ecto.Schema
  import Ecto.Changeset

  schema "courses" do
    belongs_to :user, Gradely.Users.User

    field :name, :string
    many_to_many :students, Gradely.Students.Student,
      join_through: Gradely.Enrollments.Enrollment

    timestamps()
  end

  @doc false
  def changeset(course, attrs) do
    attrs = Gradely.Utils.keys_to_atoms(attrs)
    course
    |> cast(attrs, [:name])
    |> put_assoc(:user, Map.get(attrs, :user))
    |> validate_required([:name])
  end

end

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
    |> put_assoc(:user, Map.get(attrs, :user))
    |> put_assoc(:courses, Map.get(attrs, :courses, []))
    |> validate_required([:first_name, :last_name])
  end

  @doc false
  def changeset_edit(student, attrs) do
    attrs = Gradely.Utils.ensure_atom_keys(attrs)
    student
    |> cast(attrs, [:first_name, :last_name])
    |> validate_required([:first_name, :last_name])
  end
end

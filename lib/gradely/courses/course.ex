defmodule Gradely.Courses.Course do
  use Ecto.Schema
  import Ecto.Changeset

  schema "courses" do
    field :name, :string
    belongs_to :user, Gradely.Users.User
    many_to_many :students, Gradely.Students.Student,
      join_through: Gradely.Enrollments

    timestamps()
  end

  @doc false
  def changeset(course, attrs) do
    course
    |> cast(attrs, [:name, :user_id])
    |> validate_required([:name, :user_id])
  end
end

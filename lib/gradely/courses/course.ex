defmodule Gradely.Courses.Course do
  use Ecto.Schema
  import Ecto.Changeset

  schema "courses" do
    field :name, :string
    belongs_to :user, Gradely.Users.User
    many_to_many :students, Gradely.Students.Student,
      join_through: Gradely.CourseStudent

    timestamps()
  end

  @doc false
  def changeset(course, attrs) do
    course
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end

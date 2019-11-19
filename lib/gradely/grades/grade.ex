defmodule Gradely.Grades.Grade do
  use Ecto.Schema
  import Ecto.Changeset

  schema "grades" do
    belongs_to :user, Gradely.Users.User
    belongs_to :student, Gradely.Students.Student
    belongs_to :activity, Gradely.Activities.Activity
    field :grade, :float

    timestamps()
  end

  @doc false
  def changeset(grade, attrs) do
    grade
    |> cast(attrs, [])
    |> validate_required([])
  end
end

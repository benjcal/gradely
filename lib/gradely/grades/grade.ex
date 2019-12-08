defmodule Gradely.Grades.Grade do
  use Ecto.Schema
  import Ecto.Changeset

  schema "grades" do
    belongs_to :student, Gradely.Students.Student
    belongs_to :activity, Gradely.Activities.Activity
    field :value, :float
    field :late, :boolean
    field :missing, :boolean
    field :comment, :string

    timestamps()
  end

  @doc false
  def changeset(grade, attrs) do
    grade
    |> cast(attrs, [:student_id, :activity_id, :value])
    |> validate_required([])
  end
end

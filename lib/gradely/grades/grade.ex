defmodule Gradely.Grades.Grade do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  schema "grades" do
    belongs_to :student, Gradely.Students.Student
    belongs_to :activity, Gradely.Activities.Activity
    field :value, :float
  end

  @doc false
  def changeset(grade, attrs) do
    grade
    |> cast(attrs, [:user_id, :student_id, :activity_id, :grade])
    |> validate_required([])
  end
end

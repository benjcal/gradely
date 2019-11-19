defmodule Gradely.Activities.Activity do
  use Ecto.Schema
  import Ecto.Changeset

  schema "activities" do
    field :name, :string
    belongs_to :course, Gradely.Courses.Course
    belongs_to :user, Gradely.Users.User
    has_one :grade, Gradely.Grades.Grade

    timestamps()
  end

  @doc false
  def changeset(activity, attrs) do
    activity
    |> cast(attrs, [:name, :course_id, :user_id])
    |> validate_required([:name, :course_id, :user_id])
  end
end

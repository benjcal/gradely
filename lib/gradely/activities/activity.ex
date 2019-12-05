defmodule Gradely.Activities.Activity do
  use Ecto.Schema
  import Ecto.Changeset

  schema "activities" do
    field :name, :string
    field :total_value, :float
    field :weight, :float

    belongs_to :course, Gradely.Courses.Course
    belongs_to :user, Gradely.Users.User
    belongs_to :organization, Gradely.Organizations.Organization

    has_one :grade, Gradely.Grades.Grade

    timestamps()
  end

  @doc false
  def changeset(activity, attrs) do
    activity
    |> cast(attrs, [:name, :total_value, :weight])
    |> validate_required([:name, :total_value, :weight])
  end
end

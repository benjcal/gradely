defmodule Gradely.Activities.ActivityType do
  use Ecto.Schema
  import Ecto.Changeset

  schema "activity_type" do
    field :name, :string
    field :activity_id, :id

    timestamps()
  end

  @doc false
  def changeset(activity_type, attrs) do
    activity_type
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end

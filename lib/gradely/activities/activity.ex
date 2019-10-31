defmodule Gradely.Activities.Activity do
  use Ecto.Schema
  import Ecto.Changeset

  schema "activities" do
    field :name, :string
    belongs_to :user, Gradely.Users.User

    timestamps()
  end

  @doc false
  def changeset(activity, attrs) do
    activity
    |> cast(attrs, [:name, :user_id])
    |> validate_required([:name, :user_id])
  end
end

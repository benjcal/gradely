defmodule Gradely.Activities do
  import Ecto.Query, warn: false
  import Ecto.Changeset
  alias Gradely.Repo

  alias Gradely.Activities.Activity
  alias Gradely.ActivityType

  def list_activities do
    Repo.all(Activity)
  end

  def get_activity!(id), do: Repo.get!(Activity, id)

  def create(attrs \\ %{}) do
    %Activity{}
    |> Activity.changeset(attrs[:activity])
    |> put_assoc(:user, attrs[:user])
    |> put_assoc(:course, attrs[:course])
    |> put_assoc(:organization, attrs[:organization])
    |> Repo.insert()
  end

  def update_activity(%Activity{} = activity, attrs) do
    activity
    |> Activity.changeset(attrs)
    |> Repo.update()
  end

  def delete_activity(%Activity{} = activity) do
    Repo.delete(activity)
  end

  def change_activity(%Activity{} = activity) do
    Activity.changeset(activity, %{})
  end


  def add_activity_type(attrs \\ %{}) do
    %ActivityType{}
    |> ActivityType.changeset(attrs)
    |> Repo.insert()
  end

end

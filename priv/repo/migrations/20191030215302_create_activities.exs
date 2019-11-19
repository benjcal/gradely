defmodule Gradely.Repo.Migrations.CreateActivities do
  use Ecto.Migration

  def change do
    create table(:activities) do
      add :name, :string
      add :user_id, references(:users), null: false
      add :course_id, references(:courses), null: false

      timestamps()
    end

  end
end

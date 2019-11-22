defmodule Gradely.Repo.Migrations.CreateActivities do
  use Ecto.Migration

  def change do
    create table(:activities) do
      add :user_id, references(:users), null: false
      add :course_id, references(:courses), null: false

      add :name, :string
      add :total_value, :float
      add :weight, :float


      timestamps()
    end

    create index(:activities, [:user_id])
  end
end

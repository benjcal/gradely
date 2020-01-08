defmodule Gradely.Repo.Migrations.CreateActivities do
  use Ecto.Migration

  def change do
    create table(:activities) do
      add :user_id, references(:users), null: false
      add :course_id, references(:courses), null: false

      add :name, :string
      add :due_date, :date
      add :total_value, :float
      add :weight, :float


      timestamps()
    end

  end
end

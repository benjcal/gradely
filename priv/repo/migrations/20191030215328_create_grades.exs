defmodule Gradely.Repo.Migrations.CreateGrades do
  use Ecto.Migration

  def change do
    create table(:grades) do
      add :user_id, references(:users), null: false
      add :student_id, references(:courses), null: false
      add :activity_id, references(:activities), null: false
      add :grade, :float

      timestamps()
    end

  end
end

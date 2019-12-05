defmodule Gradely.Repo.Migrations.CreateGrades do
  use Ecto.Migration

  def change do
    create table(:grades) do
      add :student_id, references(:courses), null: false
      add :activity_id, references(:activities), null: false
      add :value, :float

      timestamps()
    end

    create unique_index(:grades, [:student_id, :activity_id])

  end
end

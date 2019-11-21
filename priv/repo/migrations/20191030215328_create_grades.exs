defmodule Gradely.Repo.Migrations.CreateGrades do
  use Ecto.Migration

  def change do
    create table(:grades, primaty_key: false) do
      add :student_id, references(:courses), null: false
      add :activity_id, references(:activities), null: false
      add :value, :float
    end

    create unique_index(:grades, [:student_id, :activity_id])

  end
end

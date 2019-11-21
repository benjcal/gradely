defmodule Gradely.Repo.Migrations.CreateCourses do
  use Ecto.Migration

  def change do
    create table(:courses) do
      add :user_id, references(:users), null: false

      add :name, :string

      timestamps()
    end

    create index(:courses, [:user_id])
  end
end

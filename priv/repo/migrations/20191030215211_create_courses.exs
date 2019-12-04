defmodule Gradely.Repo.Migrations.CreateCourses do
  use Ecto.Migration

  def change do
    create table(:courses) do
      add :organization_id, references(:organizations), null: false

      add :name, :string

      timestamps()
    end

  end
end

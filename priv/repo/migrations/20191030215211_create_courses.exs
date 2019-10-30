defmodule Gradely.Repo.Migrations.CreateCourses do
  use Ecto.Migration

  def change do
    create table(:courses) do
      add :name, :string
      add :user_id, references(:users), null: false

      timestamps()
    end

  end
end

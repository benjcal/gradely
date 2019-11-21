defmodule Gradely.Repo.Migrations.CreateStudents do
  use Ecto.Migration

  def change do
    create table(:students) do
      add :user_id, references(:users), null: false

      add :first_name, :string
      add :last_name, :string

      timestamps()
    end

    create index(:students, [:user_id])
  end
end

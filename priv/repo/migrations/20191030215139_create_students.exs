defmodule Gradely.Repo.Migrations.CreateStudents do
  use Ecto.Migration

  def change do
    create table(:students) do
      add :orgnization_id, references(:organizations), null: false

      add :first_name, :string
      add :last_name, :string

      timestamps()
    end

  end
end

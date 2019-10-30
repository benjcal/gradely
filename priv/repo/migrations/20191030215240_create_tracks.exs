defmodule Gradely.Repo.Migrations.CreateTracks do
  use Ecto.Migration

  def change do
    create table(:tracks) do
      add :name, :string
      add :user_id, references(:users), null: false

      timestamps()
    end

  end
end

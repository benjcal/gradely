defmodule Gradely.Repo.Migrations.CreateTracks do
  use Ecto.Migration

  def change do
    create table(:tracks) do
      add :orgnization_id, references(:organizations), null: false

      add :name, :string
      add :user_id, references(:users), null: false

      timestamps()
    end

  end
end

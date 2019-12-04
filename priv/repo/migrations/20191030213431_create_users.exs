defmodule Gradely.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :organization_id, references(:organizations), null: false

      add :email, :string, null: false
      add :password_hash, :string
      add :preferences, :map, on_replace: :delete
      add :type, :integer, default: 1 # 0 = admin; 1 = educator

      timestamps()
    end

    create unique_index(:users, [:email])
  end
end

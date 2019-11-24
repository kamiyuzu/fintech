defmodule Fintech.Repo.Migrations.CreateBanks do
  use Ecto.Migration

  def change do
    create table(:banks) do
      add :name, :string
      add :active, :boolean, default: true, null: false

      timestamps()
    end

    create unique_index(:banks, [:name])
  end
end

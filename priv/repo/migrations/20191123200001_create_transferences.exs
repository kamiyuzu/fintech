defmodule Fintech.Repo.Migrations.CreateTransferences do
  use Ecto.Migration

  def change do
    create table(:transferences) do
      add :quantity, :decimal
      add :account_id, references(:accounts, on_delete: :nothing)

      timestamps()
    end

    create index(:transferences, [:account_id])
  end
end

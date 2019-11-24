defmodule Fintech.Repo.Migrations.CreateAccounts do
  use Ecto.Migration

  def change do
    create table(:accounts) do
      add :name, :string
      add :balance, :decimal
      add :active, :boolean, default: true, null: false
      add :customer_id, references(:customers, on_delete: :delete_all)

      timestamps()
    end

    create unique_index(:accounts, [:name])
    create index(:accounts, [:customer_id])
  end
end

defmodule Fintech.Repo.Migrations.CreateCustomers do
  use Ecto.Migration

  def change do
    create table(:customers) do
      add :email, :string
      add :name, :string
      add :phone, :string
      add :domicile, :string
      add :active, :boolean, default: true, null: false
      add :bank_id, references(:banks, on_delete: :nothing)

      timestamps()
    end

    create unique_index(:customers, [:email])
    create index(:customers, [:bank_id])
  end
end

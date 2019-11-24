defmodule Fintech.Banks.Bank do
  use Ecto.Schema
  import Ecto.Changeset

  schema "banks" do
    field :active, :boolean, default: false
    field :name, :string
    has_many :customers, Fintech.Customers.Customer

    timestamps()
  end

  @doc false
  def changeset(bank, attrs) do
    bank
    |> cast(attrs, [:name, :active])
    |> cast_assoc(:customers, required: true)
    |> validate_required([:name, :active])
    |> unique_constraint(:name)
  end
end

defmodule Fintech.Customers.Customer do
  use Ecto.Schema
  import Ecto.Changeset

  schema "customers" do
    field :active, :boolean, default: false
    field :domicile, :string
    field :email, :string
    field :name, :string
    field :phone, :string
    belongs_to :bank, Fintech.Banks.Bank
    has_many :accounts, Fintech.Accounts.Account

    timestamps()
  end

  @doc false
  def changeset(customer, attrs) do
    customer
    |> cast(attrs, [:email, :name, :phone, :domicile, :active])
    |> cast_assoc(:accounts, required: true)
    |> validate_required([:email, :name, :phone, :domicile, :active])
    |> unique_constraint(:email)
  end
end

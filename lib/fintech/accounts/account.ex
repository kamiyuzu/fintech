defmodule Fintech.Accounts.Account do
  use Ecto.Schema
  import Ecto.Changeset

  schema "accounts" do
    field :active, :boolean, default: false
    field :balance, :decimal
    field :name, :string
    belongs_to :customer, Fintech.Customers.Customer, on_replace: :update
    has_many :transferences, Fintech.Transferences.Transference

    timestamps()
  end

  @doc false
  def changeset(account, attrs) do
    account
    |> cast(attrs, [:name, :balance, :active])
    |> cast_assoc(:transferences)
    |> validate_required([:name, :balance, :active])
    |> unique_constraint(:name)
  end
end

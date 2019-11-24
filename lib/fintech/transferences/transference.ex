defmodule Fintech.Transferences.Transference do
  use Ecto.Schema
  import Ecto.Changeset

  schema "transferences" do
    field :quantity, :decimal
    belongs_to :account, Fintech.Accounts.Account

    timestamps()
  end

  @doc false
  def changeset(transference, attrs) do
    transference
    |> cast(attrs, [:quantity])
    |> validate_required([:quantity])
  end
end

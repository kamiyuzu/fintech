# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Fintech.Repo.insert!(%Fintech.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Fintech.Repo
alias Fintech.Banks.Bank

jose_acc = %{name: "Jose account", balance: 50_000.0}
jose = %{email: "jose.valim@gmail.com", name: "Jose Valim", phone: "626286574", domicile: "221B Baker Street", accounts: [jose_acc]}
bank_a = %Bank{} |> Bank.changeset(%{name: "BANK_A", customers: [jose]})
maria_acc = %{name: "Maria account", balance: 0.0}
maria = %{email: "maria@gmail.com", name: "Maria", phone: "626286575", domicile: "Fake Street", accounts: [maria_acc]}
antonio_acc = %{name: "Antonio account", balance: 50_000.0}
antonio = %{email: "antonio@gmail.com", name: "Antonio", phone: "626286576", domicile: "Fake Street 2", accounts: [antonio_acc]}
bank_b = %Bank{} |> Bank.changeset(%{name: "BANK_B", customers: [maria, antonio]})
Repo.insert!(bank_a)
Repo.insert!(bank_b)

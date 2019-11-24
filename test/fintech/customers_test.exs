defmodule Fintech.CustomersTest do
  use Fintech.DataCase

  alias Fintech.Customers

  describe "customers" do
    alias Fintech.Customers.Customer

    @valid_attrs %{active: true, domicile: "some domicile", email: "some email", name: "some name", phone: "some phone", accounts: [%{name: "testerino", balance: 0}]}
    @update_attrs %{active: false, domicile: "some updated domicile", email: "some updated email", name: "some updated name", phone: "some updated phone"}
    @invalid_attrs %{active: nil, domicile: nil, email: nil, name: nil, phone: nil}

    def customer_fixture(attrs \\ %{}) do
      {:ok, customer} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Customers.create_customer()

      customer
    end

    test "list_customers/0 returns all customers" do
      customer = customer_fixture()
      assert Customers.list_customers() |> Repo.preload(:accounts) == [customer]
    end

    test "get_customer!/1 returns the customer with given id" do
      customer = customer_fixture()
      assert Customers.get_customer!(customer.id) |> Repo.preload(:accounts) == customer
    end

    test "create_customer/1 with valid data creates a customer" do
      assert {:ok, %Customer{} = customer} = Customers.create_customer(@valid_attrs)
      assert customer.active == true
      assert customer.domicile == "some domicile"
      assert customer.email == "some email"
      assert customer.name == "some name"
      assert customer.phone == "some phone"
    end

    test "create_customer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Customers.create_customer(@invalid_attrs)
    end

    test "update_customer/2 with valid data updates the customer" do
      customer = customer_fixture()
      assert {:ok, %Customer{} = customer} = Customers.update_customer(customer, @update_attrs)
      assert customer.active == false
      assert customer.domicile == "some updated domicile"
      assert customer.email == "some updated email"
      assert customer.name == "some updated name"
      assert customer.phone == "some updated phone"
    end

    test "update_customer/2 with invalid data returns error changeset" do
      customer = customer_fixture()
      assert {:error, %Ecto.Changeset{}} = Customers.update_customer(customer, @invalid_attrs)
      assert customer == Customers.get_customer!(customer.id) |> Repo.preload(:accounts)
    end

    test "delete_customer/1 deletes the customer" do
      customer = customer_fixture()
      assert {:ok, %Customer{}} = Customers.delete_customer(customer)
      assert_raise Ecto.NoResultsError, fn -> Customers.get_customer!(customer.id) end
    end

    test "change_customer/1 returns a customer changeset" do
      customer = customer_fixture()
      assert %Ecto.Changeset{} = Customers.change_customer(customer)
    end
  end
end

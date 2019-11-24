defmodule Fintech.TransferencesTest do
  use Fintech.DataCase

  alias Fintech.Transferences

  describe "transferences" do
    alias Fintech.Transferences.Transference

    @valid_attrs %{quantity: "120.5"}
    @update_attrs %{quantity: "456.7"}
    @invalid_attrs %{quantity: nil}

    def transference_fixture(attrs \\ %{}) do
      {:ok, transference} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Transferences.create_transference()

      transference
    end

    test "list_transferences/0 returns all transferences" do
      transference = transference_fixture()
      assert Transferences.list_transferences() == [transference]
    end

    test "get_transference!/1 returns the transference with given id" do
      transference = transference_fixture()
      assert Transferences.get_transference!(transference.id) == transference
    end

    test "create_transference/1 with valid data creates a transference" do
      assert {:ok, %Transference{} = transference} = Transferences.create_transference(@valid_attrs)
      assert transference.quantity == Decimal.new("120.5")
    end

    test "create_transference/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Transferences.create_transference(@invalid_attrs)
    end

    test "update_transference/2 with valid data updates the transference" do
      transference = transference_fixture()
      assert {:ok, %Transference{} = transference} = Transferences.update_transference(transference, @update_attrs)
      assert transference.quantity == Decimal.new("456.7")
    end

    test "update_transference/2 with invalid data returns error changeset" do
      transference = transference_fixture()
      assert {:error, %Ecto.Changeset{}} = Transferences.update_transference(transference, @invalid_attrs)
      assert transference == Transferences.get_transference!(transference.id)
    end

    test "delete_transference/1 deletes the transference" do
      transference = transference_fixture()
      assert {:ok, %Transference{}} = Transferences.delete_transference(transference)
      assert_raise Ecto.NoResultsError, fn -> Transferences.get_transference!(transference.id) end
    end

    test "change_transference/1 returns a transference changeset" do
      transference = transference_fixture()
      assert %Ecto.Changeset{} = Transferences.change_transference(transference)
    end
  end
end

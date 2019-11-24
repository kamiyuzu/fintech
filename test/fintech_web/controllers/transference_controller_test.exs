defmodule FintechWeb.TransferenceControllerTest do
  use FintechWeb.ConnCase

  alias Fintech.Transferences

  @create_attrs %{quantity: "120.5"}
  @update_attrs %{quantity: "456.7"}
  @invalid_attrs %{quantity: nil}

  def fixture(:transference) do
    {:ok, transference} = Transferences.create_transference(@create_attrs)
    transference
  end

  describe "index" do
    test "lists all transferences", %{conn: conn} do
      conn = get(conn, Routes.transference_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Transferences"
    end
  end

  describe "new transference" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.transference_path(conn, :new))
      assert html_response(conn, 200) =~ "New Transference"
    end
  end

  describe "create transference" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.transference_path(conn, :create), transference: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.transference_path(conn, :show, id)

      conn = get(conn, Routes.transference_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Transference"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.transference_path(conn, :create), transference: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Transference"
    end
  end

  describe "edit transference" do
    setup [:create_transference]

    test "renders form for editing chosen transference", %{conn: conn, transference: transference} do
      conn = get(conn, Routes.transference_path(conn, :edit, transference))
      assert html_response(conn, 200) =~ "Edit Transference"
    end
  end

  describe "update transference" do
    setup [:create_transference]

    test "redirects when data is valid", %{conn: conn, transference: transference} do
      conn = put(conn, Routes.transference_path(conn, :update, transference), transference: @update_attrs)
      assert redirected_to(conn) == Routes.transference_path(conn, :show, transference)

      conn = get(conn, Routes.transference_path(conn, :show, transference))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, transference: transference} do
      conn = put(conn, Routes.transference_path(conn, :update, transference), transference: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Transference"
    end
  end

  describe "delete transference" do
    setup [:create_transference]

    test "deletes chosen transference", %{conn: conn, transference: transference} do
      conn = delete(conn, Routes.transference_path(conn, :delete, transference))
      assert redirected_to(conn) == Routes.transference_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.transference_path(conn, :show, transference))
      end
    end
  end

  defp create_transference(_) do
    transference = fixture(:transference)
    {:ok, transference: transference}
  end
end

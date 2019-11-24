defmodule FintechWeb.TransferenceController do
  use FintechWeb, :controller

  alias Fintech.Transferences
  alias Fintech.Transferences.Transference

  def index(conn, _params) do
    transferences = Transferences.list_transferences()
    render(conn, "index.html", transferences: transferences)
  end

  def new(conn, _params) do
    changeset = Transferences.change_transference(%Transference{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"transference" => transference_params}) do
    case Transferences.create_transference(transference_params) do
      {:ok, transference} ->
        conn
        |> put_flash(:info, "Transference created successfully.")
        |> redirect(to: Routes.transference_path(conn, :show, transference))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    transference = Transferences.get_transference!(id)
    render(conn, "show.html", transference: transference)
  end

  def edit(conn, %{"id" => id}) do
    transference = Transferences.get_transference!(id)
    changeset = Transferences.change_transference(transference)
    render(conn, "edit.html", transference: transference, changeset: changeset)
  end

  def update(conn, %{"id" => id, "transference" => transference_params}) do
    transference = Transferences.get_transference!(id)

    case Transferences.update_transference(transference, transference_params) do
      {:ok, transference} ->
        conn
        |> put_flash(:info, "Transference updated successfully.")
        |> redirect(to: Routes.transference_path(conn, :show, transference))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", transference: transference, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    transference = Transferences.get_transference!(id)
    {:ok, _transference} = Transferences.delete_transference(transference)

    conn
    |> put_flash(:info, "Transference deleted successfully.")
    |> redirect(to: Routes.transference_path(conn, :index))
  end
end

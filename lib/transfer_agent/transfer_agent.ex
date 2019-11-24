defmodule Fintech.TransferAgent do
  use GenServer, restart: :transient, shutdown: 30_000
  use Fintech.TransferAgent.Helpers, :helper

  require Logger

  alias Fintech.Transferences.Transference

  @types get_transfer_list_types()

  @moduledoc """
  This module provides the requirements to implement the transfer agent for a fintech company
  """

  @doc """
  Callback function when the GenServer is started
  """
  @impl true
  def init(store) do
    {:ok, store}
  end

  @doc """
  Makes the async cast for a inter-transference
  """
  @impl true
  def handle_cast({:inter = type, transference = %Transference{}}, state) when type in @types do
    Logger.info("Received '#{type}-transference' from account-id: #{transference.account_id}")
    new_state = state |> check_transference(transference, type, 5, 30)
    {:noreply, new_state}
  end

  @doc """
  Makes the async cast for a intra-transference
  """
  @impl true
  def handle_cast({:intra = type, transference = %Transference{}}, state) when type in @types do
    Logger.info("Received '#{type}-transference' from account-id: #{transference.account_id}")
    new_state = state |> check_transference(transference, type, 0, 0)
    {:noreply, new_state}
  end

  @doc """
  Starts the GenServer
  """
  def start_link(_) do
    GenServer.start_link(__MODULE__, %{}, name: TA)
  end

  @doc """
  Calls the GenServer for making a transference
  ## Examples

    iex> alias Fintech.Transferences.Transference
    iex> Fintech.TransferAgent.transfer({:intra, %Transference{account_id: 1, quantity: 100}})
    :ok
  """
  def transfer({type, transference}) do
   GenServer.cast(TA, {type, transference})
  end

end

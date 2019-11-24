defmodule Fintech.TransferAgent.Service do
  require Logger

  alias Fintech.Transferences.Transference
  alias Fintech.{Accounts, Accounts.Account}

  @moduledoc """
  This module provides the functions required to comunicate with the database
  """

  @doc """
  Function in charge of validating the transference
  """
  def check_transference(state, transference = %Transference{quantity: quantity}, :inter = type, 5, 30) do
    Logger.info("Checked '#{type}-transference' from account-id: #{transference.account_id}")
    amount = Decimal.new(quantity)
    limit = Decimal.new(1000)
    cond do
      amount <= limit ->
        check_failure(state, transference, 5, 30)
      amount > limit ->
        {div, rem} = Decimal.div_rem(amount, limit)
        Enum.each(1..Decimal.to_integer(div), fn _ ->
          check_failure(state, %{transference | quantity: Decimal.to_integer(div) * 1000}, 5, 30)
        end)
        if rem > 0 do
          check_failure(state, %{transference | quantity: Decimal.to_integer(rem)}, 5, 30)
        end
    end
  end
  def check_transference(state, transference = %Transference{}, :intra = type, 0, 0) do
    Logger.info("Checked '#{type}-transference' from account-id: #{transference.account_id}")
    check_account(state, transference, 0, 0)
  end

  @doc """
  Function simulating the failure rate
  """
  def check_failure(state,transference, 5, 30) do
    failure = :rand.uniform()
    cond do
      failure > 0.3 ->
        check_account(state, transference, 5, 30)
      true ->
        Logger.error("Transference from account-id: #{transference.account_id} couldn't be performed.")
    end
  end

  @doc """
  Function in charge of checking account from database
  """
  def check_account(state, transference, 0, 0) do
    case Accounts.get_account!(transference.account_id) do
      account = %Account{} ->
        Logger.info("Checked account-id: #{transference.account_id}")
          account
        |> back_transference(transference, state)
      _ ->
        Logger.error "Transaction failed from account-id: #{transference.account_id}. Does not exist account on database."
    end
  end

  def check_account(state, transference, 5, 30) do
    case Accounts.get_account!(transference.account_id) do
      account = %Account{} ->
        Logger.info("Checked account-id: #{transference.account_id}")
          account
        |> back_inter_transference(transference, state, 5, 30)
      _ ->
        Logger.error "Transaction failed from account-id: #{transference.account_id}. Does not exist account on database."
    end
  end

  @doc """
  Function in charge of backing the transference into database
  """
  def back_transference(account, transference, state) do
    {acc_with_transferences, transferences_map} = get_account_with_transferences(account, transference)
    case Accounts.update_account(acc_with_transferences, %{transferences: transferences_map}) do
      {:ok, transaction_done} ->
        Logger.info "Transaction completed with id: '#{transaction_done.id}'"
        state |> Map.put(transaction_done.id, transaction_done)
      {:error, failed_transaction} ->
        Logger.error "Transaction failed: '#{failed_transaction}'"
        state
    end
  end

  @doc """
  Function in charge of getting from database the data required for the update operation
  """
  def get_account_with_transferences(account, transference) do
    transference_map = Map.from_struct(transference)
    acc_with_transferences = account |> Fintech.Repo.preload(:transferences)
    transferences_map =
    Enum.reduce(acc_with_transferences.transferences, [], fn(transference, acc) ->
      [Map.from_struct(transference) | acc]
    end) ++ [transference_map]
    {acc_with_transferences, transferences_map}
  end

  @doc """
  Function in charge of backing the inter transference into database
  """
  def back_inter_transference(account, transference, state, 5, 30) do
    {acc_with_transferences, acc_with_transferences_charged, transferences_map} = get_account_with_transferences_inter(account, transference, 5, 30)
    case Accounts.update_account(acc_with_transferences, %{balance: acc_with_transferences_charged.balance, transferences: transferences_map}) do
      {:ok, transaction_done} ->
        Logger.info "Transaction completed with id: '#{transaction_done.id}'"
        state |> Map.put(transaction_done.id, transaction_done)
      {:error, failed_transaction} ->
        Logger.error "Transaction failed: '#{failed_transaction}'"
        state
    end
  end

  @doc """
  Function in charge of getting from database the data required for the update operation
  """
  def get_account_with_transferences_inter(account, transference = %Transference{quantity: quantity}, 5, 30) do
    transference_map = Map.from_struct(transference)
    acc_with_transferences = account |> Fintech.Repo.preload(:transferences)
    new_balance = Decimal.sub(Decimal.sub(acc_with_transferences.balance, Decimal.new(quantity)), Decimal.new(5))
    acc_with_transferences_charged = %{acc_with_transferences | balance: new_balance}
    transferences_map =
    Enum.reduce(acc_with_transferences_charged.transferences, [], fn(transference, acc) ->
      [Map.from_struct(transference) | acc]
    end) ++ [transference_map]
    {acc_with_transferences, acc_with_transferences_charged, transferences_map}
  end

end

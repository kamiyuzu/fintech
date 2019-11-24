defmodule Fintech.TransferAgent.Config do
  @moduledoc """
  This module provides configuration for the transfer agent
  """

  @doc """
  Gets the transfereces valid types for the transfer agent by config

  ## Examples

      iex> Fintech.TransferAgent.Config.get_transfer_list_types()
      [:inter, :intra]

  """
  def get_transfer_list_types, do: Application.get_env(:fintech, :types)

end

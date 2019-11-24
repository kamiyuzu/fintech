defmodule Fintech.TransferAgent.Helpers do
  @moduledoc """
  This module provides the functions required to Transfer Agent
  """

  @doc """
  Function providing the desired imports
  """
  def helper do
    quote do
      import Fintech.TransferAgent.Service
      import Fintech.TransferAgent.Config
    end
  end

  @doc """
  Function provides the use macro for the helper
  """
  defmacro __using__(:helper = which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end

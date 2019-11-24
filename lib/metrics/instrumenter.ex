defmodule Fintech.Instrumenter do
  require Logger

  @moduledoc """
  This module provides the metrics for the fintech company
  """

  @doc """
  Function to setup telemetry
  """
  def setup do
    events = [
      [:fintech, :repo, :query],          # to capture DB queries
      [:fintech, :plug, :start],          # Captures the time the request began
      [:fintech, :plug, :stop],           # Captures the duration the request took
      [:web, :request, :start],           # to capture web petitions
      [:web, :request, :success],         # to capture HTTP 200s
      [:web, :request, :failure],         # to capture web errors
    ]

    :telemetry.attach_many("fintech-instrumenter", events, &handle_event/4, nil)
  end

  @doc """
  Function for handling of telemetry events
  """
  def handle_event([:fintech, :repo, :query], measurements, metadata, _config) do
    log_metrics(measurements, metadata)
  end

  def handle_event([:fintech, :plug, :start], measurements, metadata, _config) do
    log_metrics(measurements, metadata)
  end

  def handle_event([:fintech, :plug, :stop], measurements, metadata, _config) do
    log_metrics(measurements, metadata)
  end

  def handle_event([:web, :request, :start], measurements, metadata, _config) do
    log_metrics(measurements, metadata)
  end

  def handle_event([:web, :request, :success], measurements, metadata, _config) do
    log_metrics(measurements, metadata)
  end

  def handle_event([:web, :request, :failure], measurements, metadata, _config) do
    log_metrics(measurements, metadata)
  end

  @doc """
  Function for inspecting the events from telemetry
  """
  def log_metrics(measurements, metadata) do
    measurements |> IO.inspect
    metadata |> IO.inspect
  end
end

defmodule FintechWeb.Router do
  use FintechWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Plug.Telemetry, event_prefix: [:fintech, :plug]
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", FintechWeb do
    pipe_through :browser

    get "/", PageController, :index
    resources "/banks", BankController
    resources "/customers", CustomerController
    resources "/accounts", AccountController
    resources "/transferences", TransferenceController

  end

  # Other scopes may use custom stacks.
  # scope "/api", FintechWeb do
  #   pipe_through :api
  # end
end

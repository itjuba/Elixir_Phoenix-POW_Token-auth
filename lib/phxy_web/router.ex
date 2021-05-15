defmodule PhxyWeb.Router do
  use PhxyWeb, :router
  use Pow.Phoenix.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end


  pipeline :api_protected do
    plug Pow.Plug.RequireAuthenticated, error_handler: PhxyWeb.APIAuthErrorHandler
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug PhxyWeb.APIAuthPlug, otp_app: :phxy
  end





    scope "/api" ,PhxyWeb do
    pipe_through :api

    resources "/registration", RegistrationController, singleton: true, only: [:create]
    resources "/session", SessionController, singleton: true, only: [:create, :delete]

    post "/session/renew", SessionController, :renew
    get "/", PageController, :index
	
    end
  scope "/api", PhxyWeb do
    pipe_through [:api, :api_protected]
    resources "/users", UserController, only: [:index]

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.


  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: PhxyWeb.Telemetry
    end
  end
end

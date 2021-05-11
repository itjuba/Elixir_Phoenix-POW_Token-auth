defmodule Phxy.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Phxy.Repo,
      # Start the Telemetry supervisor
      PhxyWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Phxy.PubSub},
      # Start the Endpoint (http/https)
      PhxyWeb.Endpoint
      # Start a worker by calling: Phxy.Worker.start_link(arg)
      # {Phxy.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Phxy.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    PhxyWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end

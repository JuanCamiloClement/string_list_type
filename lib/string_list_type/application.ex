defmodule StringListType.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      StringListTypeWeb.Telemetry,
      StringListType.Repo,
      {DNSCluster, query: Application.get_env(:string_list_type, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: StringListType.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: StringListType.Finch},
      # Start a worker by calling: StringListType.Worker.start_link(arg)
      # {StringListType.Worker, arg},
      # Start to serve requests, typically the last entry
      StringListTypeWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: StringListType.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    StringListTypeWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end

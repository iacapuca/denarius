defmodule Spintria.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  require Logger

  @impl true
  def start(_type, _args) do
    children = [
      # Starts a worker by calling: Spintria.Worker.start_link(arg)
      # {Spintria.Worker, arg}
      {Plug.Cowboy,
       scheme: :http,
       plug: Spintria.Router,
       options: [port: (System.get_env("PORT") || "4040") |> String.to_integer()]},
      {Spintria.Repo, []}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Spintria.Supervisor]
    Logger.info("The server listening at port: #{System.get_env("PORT") || "4040"}")
    Supervisor.start_link(children, opts)
  end
end

defmodule Enjoybot.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  alias Alchemy.Client

  defp load_modules do
    use Enjoybot.Commands
  end

  @impl true
  def start(_type, _args) do
    children = [
      # Starts a worker by calling: Enjoybot.Worker.start_link(arg)
      # {Enjoybot.Worker, arg}
    ]

    Client.start(Application.get_env(:enjoybot, :token))
    load_modules()

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Enjoybot.Supervisor]
    Supervisor.start_link(children, opts)
  end
end

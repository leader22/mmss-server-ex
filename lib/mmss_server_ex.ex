defmodule MMSSServer do
  @moduledoc """
  Documentation for MMSSServer.
  """

  use Application
  require Logger

  def start(_type, _args) do
    env = Application.get_all_env(:mmss_server_ex)
    Logger.info("""
    Starting app on env...
      mpath:     #{env[:mpath]}
      port:      #{env[:port]}
      user/pass: #{env[:user]}/#{env[:pass]}
    """)

    children = [
      Plug.Adapters.Cowboy.child_spec(:http, MMSSServer.Router, [env], port: env[:port])
    ]
    opts = [strategy: :one_for_one, name: MMSSServer.Supervisor]
    Supervisor.start_link(children, opts)
  end
end

defmodule MMSSServer do
  @moduledoc """
  My Mp3 Streaming Server SERVER implementation.
  """

  use Application
  require Logger

  alias Plug.Adapters.Cowboy

  def start(_type, _args) do
    env = Application.get_all_env(:mmss_server_ex)

    Logger.info("""
    Starting app on env...
      mpath:     #{env[:mpath]}
      port:      #{env[:port]}
      user/pass: #{env[:user]}/#{env[:pass]}
    """)

    Supervisor.start_link(
      [
        Cowboy.child_spec(
          :http,
          MMSSServer.Server,
          [env],
          port: env[:port]
        )
      ],
      strategy: :one_for_one,
      name: MMSSServer.Supervisor
    )
  end
end

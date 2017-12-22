defmodule MMSSServer do
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

    Supervisor.start_link(
      [
        Plug.Adapters.Cowboy.child_spec(
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

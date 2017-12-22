defmodule MMSSServer do
  @moduledoc """
  My Mp3 Streaming Server SERVER implementation.
  """

  use Application
  require Logger

  alias Plug.Adapters.Cowboy

  def start(_type, _args) do
    mpath = Env.fetch!(:mmss_server_ex, :mpath)
    port = Env.fetch!(:mmss_server_ex, :port)
    user = Env.fetch!(:mmss_server_ex, :user)
    pass = Env.fetch!(:mmss_server_ex, :pass)

    Logger.info("""
    Starting app on env...
      mpath:     #{mpath}
      port:      #{port}
      user/pass: #{user}/#{pass}
    """)

    Supervisor.start_link(
      [
        Cowboy.child_spec(
          :http,
          MMSSServer.Server,
          [],
          port: String.to_integer(port)
        )
      ],
      strategy: :one_for_one,
      name: MMSSServer.Supervisor
    )
  end
end

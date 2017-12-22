defmodule MMSSServer.Routes.Authorized do
  import Plug.Conn

  def get_session(conn) do
    MMSSServer.Server.send_json(conn, 200, nil)
  end

  def get_track(conn) do
    conn = fetch_query_params(conn)
    path = conn.params["path"]
    mpath = Application.get_env(:mmss_server_ex, :mpath)

    MMSSServer.Server.send_mp3(conn, 200, "#{mpath}/#{path}")
  end

  def unauthorized(conn) do
    MMSSServer.Server.send_json(conn, 401, %{error: 3})
  end
end

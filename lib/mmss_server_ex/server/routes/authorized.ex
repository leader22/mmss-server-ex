defmodule MMSSServer.Routes.Authorized do
  import Plug.Conn

  def get_session(conn) do
    if !login?(conn) do
      MMSSServer.Server.send_json(conn, 401, %{error: 3})
    end

    MMSSServer.Server.send_json(conn, 200, nil)
  end

  def get_track(conn) do
    if !login?(conn) do
      MMSSServer.Server.send_json(conn, 401, %{error: 3})
    end

    conn = fetch_query_params(conn)
    path = conn.params["path"]
    IO.inspect(path)

    MMSSServer.Server.send_json(conn, 200, nil)
  end

  defp login?(conn) do
    nil !=
      conn
      |> fetch_session()
      |> get_session(:isLogin)
  end
end

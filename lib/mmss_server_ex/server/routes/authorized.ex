defmodule MMSSServer.Routes.Authorized do
  import Plug.Conn

  def get_session(conn) do
    if !login?(conn) do
      unauthorized(conn)
    end

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Poison.encode!(nil))
  end

  def get_track(conn) do
    if !login?(conn) do
      unauthorized(conn)
    end

    conn = fetch_query_params(conn)
    path = conn.params["path"]
    IO.inspect(path)

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Poison.encode!(nil))
  end

  defp unauthorized(conn) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(401, Poison.encode!(%{error: 3}))
  end

  defp login?(conn) do
    nil !=
      conn
      |> fetch_session()
      |> get_session(:isLogin)
  end
end

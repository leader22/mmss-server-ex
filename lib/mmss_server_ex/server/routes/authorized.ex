defmodule MMSSServer.Routes.Authorized do
  import Plug.Conn

  def get_session(conn) do
    if !login?(conn) do
      conn
      |> put_resp_content_type("application/json")
      |> send_resp(401, Poison.encode!(%{error: 3}))
    end

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Poison.encode!(nil))
  end

  def get_track(conn) do
    conn = fetch_query_params(conn)
    path = conn.params["path"]
    IO.inspect(path)

    if !login?(conn) do
      conn
      |> put_resp_content_type("application/json")
      |> send_resp(401, Poison.encode!(%{error: 3}))
    end

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Poison.encode!(nil))
  end

  defp login?(conn) do
    conn
    |> fetch_session()
    |> get_session(:isLogin)
  end
end

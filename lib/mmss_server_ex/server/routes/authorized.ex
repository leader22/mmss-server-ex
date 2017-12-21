defmodule MMSSServer.Routes.Authorized do
  import Plug.Conn

  def getSession(conn) do
    if isLogin(conn) == false do
      conn
      |> put_resp_content_type("application/json")
      |> send_resp(401, Poison.encode!(%{error: 3}))
    end

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Poison.encode!(nil))
  end

  def getTrack(conn) do
    conn = fetch_query_params(conn)
    path = conn.params["path"]
    IO.inspect(path)

    if isLogin(conn) == false do
      conn
      |> put_resp_content_type("application/json")
      |> send_resp(401, Poison.encode!(%{error: 3}))
    end

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Poison.encode!(nil))
  end

  defp isLogin(_conn) do
    # TODO: check session.cred
    false
  end
end

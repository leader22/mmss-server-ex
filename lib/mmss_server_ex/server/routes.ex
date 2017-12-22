defmodule MMSSServer.Routes do
  import Plug.Conn

  def postLogin(conn) do
    # TODO: parse body
    # TODO: check cred, bake session cookie

    conn
    |> fetch_session()
    |> put_session(:isLogin, true)
    |> put_resp_content_type("application/json")
    |> send_resp(200, Poison.encode!(nil))
  end

  def postLogout(conn) do
    conn
    |> fetch_session()
    |> delete_session(:isLogin)
    |> put_resp_content_type("application/json")
    |> send_resp(200, Poison.encode!(nil))
  end
end

defmodule MMSSServer.Routes do
  import Plug.Conn

  def post_login(conn) do
    # TODO: parse body
    # TODO: check cred, bake session cookie

    conn
    |> fetch_session()
    |> put_session(:isLogin, true)
    |> MMSSServer.Server.send_json(200, nil)
  end

  def post_logout(conn) do
    conn
    |> fetch_session()
    |> delete_session(:isLogin)
    |> MMSSServer.Server.send_json(200, nil)
  end
end

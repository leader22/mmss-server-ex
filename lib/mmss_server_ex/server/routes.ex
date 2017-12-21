defmodule MMSSServer.Routes do
  import Plug.Conn

  def postLogin(conn) do
    # TODO: parse body
    # TODO: check cred, bake session cookie

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Poison.encode!(nil))
  end

  def postLogout(conn) do
    # TODO: purge session cookie

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Poison.encode!(nil))
  end
end

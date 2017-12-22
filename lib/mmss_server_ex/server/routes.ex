defmodule MMSSServer.Routes do
  import Plug.Conn

  def post_login(conn) do
    cond do
      invalid_params?(conn) ->
        MMSSServer.Server.send_json(conn, 400, %{
          error: MMSSServer.Server.Error.errInvalidParams()
        })

      invalid_cred?(conn) ->
        MMSSServer.Server.send_json(conn, 403, %{error: MMSSServer.Server.Error.errLoginFailure()})

      true ->
        conn
        |> fetch_session()
        |> put_session(:isLogin, true)
        |> MMSSServer.Server.send_json(200, nil)
    end
  end

  def post_logout(conn) do
    conn
    |> fetch_session()
    |> delete_session(:isLogin)
    |> MMSSServer.Server.send_json(200, nil)
  end

  defp invalid_params?(conn) do
    has_id = Map.has_key?(conn.body_params, "id")
    has_pw = Map.has_key?(conn.body_params, "pw")

    (has_id and has_pw) == false
  end

  defp invalid_cred?(conn) do
    env_cred =
      MMSSServer.Server.Util.sha256(
        Application.get_env(:mmss_server_ex, :user),
        Application.get_env(:mmss_server_ex, :pass)
      )

    body_cred =
      MMSSServer.Server.Util.sha256(
        conn.body_params["id"],
        conn.body_params["pw"]
      )

    env_cred == body_cred == false
  end
end

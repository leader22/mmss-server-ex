defmodule MMSSServer.Server.Routes do
  @moduledoc """
  Handlers for each route before login.
  """

  import Plug.Conn

  alias MMSSServer.Server.Error
  alias MMSSServer.Server.Util

  def post_login(conn) do
    cond do
      invalid_params?(conn) ->
        Util.send_json(conn, 400, %{error: Error.err_invalid_params()})

      invalid_cred?(conn) ->
        Util.send_json(conn, 403, %{error: Error.err_login_failure()})

      true ->
        conn
        |> fetch_session()
        |> put_session(:isLogin, true)
        |> Util.send_json(200, nil)
    end
  end

  def post_logout(conn) do
    conn
    |> fetch_session()
    |> delete_session(:isLogin)
    |> Util.send_json(200, nil)
  end

  defp invalid_params?(conn) do
    has_id = Map.has_key?(conn.body_params, "id")
    has_pw = Map.has_key?(conn.body_params, "pw")

    (has_id and has_pw) == false
  end

  defp invalid_cred?(conn) do
    env_cred =
      Util.sha256(
        Application.get_env(:mmss_server_ex, :user),
        Application.get_env(:mmss_server_ex, :pass)
      )

    body_cred =
      Util.sha256(
        conn.body_params["id"],
        conn.body_params["pw"]
      )

    env_cred == body_cred == false
  end
end

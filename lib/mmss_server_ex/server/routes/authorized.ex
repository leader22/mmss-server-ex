defmodule MMSSServer.Server.Routes.Authorized do
  import Plug.Conn

  alias MMSSServer.Server.Error
  alias MMSSServer.Server.Util

  def get_session(conn) do
    Util.send_json(conn, 200, nil)
  end

  def get_track(conn) do
    cond do
      invalid_params?(conn) ->
        Util.send_json(conn, 400, %{error: Error.errInvalidParams()})

      invalid_path?(conn) ->
        Util.send_json(conn, 400, %{error: Error.errInvalidParams()})

      true ->
        path = fetch_query_params(conn).params["path"]
        mpath = Application.get_env(:mmss_server_ex, :mpath)
        Util.send_mp3(conn, 200, "#{mpath}/#{path}")
    end
  end

  def unauthorized(conn) do
    Util.send_json(conn, 401, %{
      error: Error.errAuthorizationRequired()
    })
  end

  defp invalid_params?(conn) do
    Map.has_key?(conn.query_params, "path") == false
  end

  defp invalid_path?(conn) do
    path = fetch_query_params(conn).params["path"]
    mpath = Application.get_env(:mmss_server_ex, :mpath)

    case File.stat("#{mpath}/#{path}") do
      {:ok, _stat} -> false
      {:error, _reason} -> true
    end
  end
end

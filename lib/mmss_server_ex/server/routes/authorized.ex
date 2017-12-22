defmodule MMSSServer.Routes.Authorized do
  import Plug.Conn

  def get_session(conn) do
    MMSSServer.Server.send_json(conn, 200, nil)
  end

  def get_track(conn) do
    cond do
      invalid_params?(conn) ->
        MMSSServer.Server.send_json(conn, 400, %{
          error: MMSSServer.Server.Error.errInvalidParams()
        })

      invalid_path?(conn) ->
        MMSSServer.Server.send_json(conn, 400, %{
          error: MMSSServer.Server.Error.errInvalidParams()
        })

      true ->
        path = fetch_query_params(conn).params["path"]
        mpath = Application.get_env(:mmss_server_ex, :mpath)
        MMSSServer.Server.send_mp3(conn, 200, "#{mpath}/#{path}")
    end
  end

  def unauthorized(conn) do
    MMSSServer.Server.send_json(conn, 401, %{
      error: MMSSServer.Server.Error.errAuthorizationRequired()
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

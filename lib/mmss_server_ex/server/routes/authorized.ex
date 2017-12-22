defmodule MMSSServer.Server.Routes.Authorized do
  @moduledoc """
  Handlers for each route after login.
  """

  import Plug.Conn

  alias MMSSServer.Server.Error
  alias MMSSServer.Server.Util

  @spec get_session(Plug.Conn.t()) :: Plug.Conn.t()
  def get_session(conn) do
    Util.send_json(conn, 200, nil)
  end

  @spec get_track(Plug.Conn.t()) :: Plug.Conn.t()
  def get_track(conn) do
    cond do
      invalid_params?(conn) ->
        Util.send_json(conn, 400, %{error: Error.err_invalid_params()})

      invalid_path?(conn) ->
        Util.send_json(conn, 400, %{error: Error.err_invalid_params()})

      true ->
        path = fetch_query_params(conn).params["path"]
        mpath = Env.fetch!(:mmss_server_ex, :mpath)
        Util.send_mp3(conn, 200, "#{mpath}/#{path}")
    end
  end

  @spec unauthorized(Plug.Conn.t()) :: Plug.Conn.t()
  def unauthorized(conn) do
    Util.send_json(conn, 401, %{
      error: Error.err_authorization_required()
    })
  end

  @spec invalid_params?(Plug.Conn.t()) :: boolean
  defp invalid_params?(conn) do
    Map.has_key?(conn.query_params, "path") == false
  end

  @spec invalid_path?(Plug.Conn.t()) :: boolean
  defp invalid_path?(conn) do
    path = fetch_query_params(conn).params["path"]
    mpath = Env.fetch!(:mmss_server_ex, :mpath)

    case File.stat("#{mpath}/#{path}") do
      {:ok, _stat} -> false
      {:error, _reason} -> true
    end
  end
end

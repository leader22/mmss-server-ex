defmodule MMSSServer.Server do
  @moduledoc """
  Define and handle routes for our JSON API Server.
  """

  use Plug.Router

  alias MMSSServer.Server.Routes
  alias MMSSServer.Server.Routes.Authorized
  alias MMSSServer.Server.Error
  alias MMSSServer.Server.Util

  plug(:match)

  plug(
    Plug.Session,
    store: :ets,
    key: "sid",
    table: :session
  )

  plug(:fetch_session)

  plug(
    Plug.Parsers,
    parsers: [:urlencoded, :json],
    json_decoder: Poison
  )

  plug(:fetch_query_params)

  plug(:dispatch)

  def init(opts) do
    :ets.new(:session, [:named_table, :public])
    opts
  end

  # routes
  post "/login" do
    Routes.post_login(conn)
  end

  post "/logout" do
    Routes.post_logout(conn)
  end

  # authorized routes
  get "/session" do
    if !login?(conn) do
      Authorized.unauthorized(conn)
    end

    Authorized.get_session(conn)
  end

  get "/track" do
    if !login?(conn) do
      Authorized.unauthorized(conn)
    end

    Authorized.get_track(conn)
  end

  match _ do
    Util.send_json(conn, 404, %{error: Error.err_route_not_found()})
  end

  @spec login?(Plug.Conn.t()) :: boolean
  defp login?(conn) do
    nil != get_session(conn, :isLogin)
  end
end

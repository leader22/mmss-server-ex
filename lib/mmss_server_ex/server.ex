defmodule MMSSServer.Server do
  @moduledoc """
  Define and handle routes for our JSON API Server.
  """

  use Plug.Router

  import MMSSServer.Server.Plug, only: [put_secret_key_base: 2]

  alias MMSSServer.Server.Routes
  alias MMSSServer.Server.Routes.Authorized
  alias MMSSServer.Server.Error
  alias MMSSServer.Server.Util

  # XXX: could not verify session cookie
  plug(:put_secret_key_base)

  plug(
    Plug.Session,
    store: :cookie,
    key: "mmss-server-sid",
    signing_salt: "mmss-server"
  )

  plug(
    Plug.Parsers,
    parsers: [:urlencoded, :json],
    json_decoder: Poison
  )

  plug(:match)
  plug(:dispatch)

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

  defp login?(conn) do
    nil !=
      conn
      |> fetch_session()
      |> get_session(:isLogin)
  end
end

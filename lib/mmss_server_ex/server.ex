defmodule MMSSServer.Server do
  use Plug.Router
  import MMSSServer.Server.Plug, only: [put_secret_key_base: 2]

  # TODO: could not verify session cookie
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
    MMSSServer.Routes.post_login(conn)
  end

  post "/logout" do
    MMSSServer.Routes.post_logout(conn)
  end

  # authorized routes
  get "/session" do
    if !login?(conn) do
      MMSSServer.Routes.Authorized.unauthorized(conn)
    end

    MMSSServer.Routes.Authorized.get_session(conn)
  end

  get "/track" do
    if !login?(conn) do
      MMSSServer.Routes.Authorized.unauthorized(conn)
    end

    MMSSServer.Routes.Authorized.get_track(conn)
  end

  match _ do
    send_json(conn, 404, %{error: 4})
  end

  def send_json(conn, status, data) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(status, Poison.encode!(data))
  end

  def send_mp3(conn, status, path) do
    conn
    |> put_resp_content_type("audio/mpeg")
    |> send_file(status, path)
  end

  defp login?(conn) do
    nil !=
      conn
      |> fetch_session()
      |> get_session(:isLogin)
  end
end

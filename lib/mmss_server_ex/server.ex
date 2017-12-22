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
    MMSSServer.Routes.Authorized.get_session(conn)
  end

  get "/track" do
    MMSSServer.Routes.Authorized.get_track(conn)
  end

  match _ do
    conn
    |> send_resp(404, "Oops!")
  end
end

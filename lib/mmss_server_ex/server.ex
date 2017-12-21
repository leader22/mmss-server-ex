defmodule MMSSServer.Server do
  use Plug.Router

  plug(MMSSServer.Server.Plug.PutSecretKeyBase)
  plug(
    Plug.Session,
    store: :cookie,
    key: "mmss-server-sid",
    signing_salt: "mmss-server"
  )
  plug(:match)
  plug(:dispatch)
  # plug(Plug.Parsers, json_decoder: Poison)

  get "/p" do
    conn = fetch_session(conn)
    conn = put_session(conn, "foo", true)

    conn |> send_resp(200, "ok")
  end

  get "/d" do
    conn = fetch_session(conn)
    conn = delete_session(conn, "foo")

    conn |> send_resp(200, "ok")
  end

  get "/" do
    conn = fetch_session(conn)
    foo = get_session(conn, "foo")
    IO.inspect(foo)

    conn |> send_resp(200, "ok")
  end

  # routes
  post "/login" do
    MMSSServer.Routes.postLogin(conn)
  end

  post "/logout" do
    MMSSServer.Routes.postLogout(conn)
  end

  # authorized routes
  get "/session" do
    MMSSServer.Routes.Authorized.getSession(conn)
  end

  get "/track" do
    MMSSServer.Routes.Authorized.getTrack(conn)
  end

  match _ do
    conn
    |> send_resp(404, "Oops!")
  end
end

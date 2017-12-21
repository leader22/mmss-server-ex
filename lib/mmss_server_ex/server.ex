defmodule MMSSServer.Server do
  use Plug.Router

  plug(
    Plug.Session,
    store: :cookie,
    key: "mmss-server-sid",
    signing_salt: "mmss-server"
  )

  # plug(MMSSServer.Plug.Auth)
  plug(:match)
  plug(:dispatch)

  def init([env]) do
    IO.puts("Router.init")
    IO.inspect(env)
    false
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

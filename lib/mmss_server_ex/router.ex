defmodule MMSSServer.Router do
  use Plug.Router

  plug(:match)
  plug(:dispatch)

  def init([env]) do
    IO.inspect(env)
    false
  end

  get("/") do
    conn
    |> send_resp(200, "Hi")
  end

  match(_) do
    conn
    |> send_resp(404, "Oops!")
  end
end

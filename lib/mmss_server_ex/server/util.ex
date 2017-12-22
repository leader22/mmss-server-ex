defmodule MMSSServer.Server.Util do
  import Plug.Conn

  def sha256(salt, pass) do
    hash = :crypto.hmac(:sha256, salt, pass)
    Base.encode16(hash, case: :lower)
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
end

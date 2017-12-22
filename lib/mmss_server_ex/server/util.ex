defmodule MMSSServer.Server.Util do
  @moduledoc """
  Utilitiy functions.
  """

  import Plug.Conn

  @spec sha256(String.t(), String.t()) :: String.t()
  def sha256(salt, pass) do
    hash = :crypto.hmac(:sha256, salt, pass)
    Base.encode16(hash, case: :lower)
  end

  @spec send_json(Plug.Conn.t(), integer, map | nil) :: Plug.Conn.t()
  def send_json(conn, status, data) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(status, Poison.encode!(data))
  end

  @spec send_mp3(Plug.Conn.t(), integer, String.t()) :: Plug.Conn.t()
  def send_mp3(conn, status, path) do
    conn
    |> put_resp_content_type("audio/mpeg")
    |> send_file(status, path)
  end
end

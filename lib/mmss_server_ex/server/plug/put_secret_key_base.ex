defmodule MMSSServer.Server.Plug.PutSecretKeyBase do
  def init(opts) do
    opts
  end

  def call(conn, _) do
    key = Application.get_env(:mmss_server_ex, :secret_key_base)
    put_in(conn.secret_key_base, key)
  end
end

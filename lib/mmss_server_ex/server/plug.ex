defmodule MMSSServer.Server.Plug do
  def putSecretKeyBase(conn, _opts) do
    key = Application.get_env(:mmss_server_ex, :secret_key_base)
    put_in(conn.secret_key_base, key)
  end
end

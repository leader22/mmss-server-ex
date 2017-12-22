defmodule MMSSServer.Server.Plug do
  @moduledoc """
  Costom plug implementations.
  """

  def put_secret_key_base(conn, _opts) do
    key = Application.get_env(:mmss_server_ex, :secret_key_base)
    put_in(conn.secret_key_base, key)
  end
end

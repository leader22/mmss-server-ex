defmodule MMSSServer.Server.Plug do
  @moduledoc """
  Costom plug implementations.
  """

  @spec put_secret_key_base(Plug.Conn.t(), Plug.opts()) :: Plug.Conn.t()
  def put_secret_key_base(conn, _opts) do
    key = Env.fetch!(:mmss_server_ex, :secret_key_base)
    put_in(conn.secret_key_base, key)
  end
end

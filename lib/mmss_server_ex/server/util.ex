defmodule MMSSServer.Server.Util do
  def sha256(salt, pass) do
    :crypto.hmac(:sha256, salt, pass)
    |> Base.encode16(case: :lower)
  end
end

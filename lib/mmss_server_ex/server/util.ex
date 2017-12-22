defmodule MMSSServer.Server.Util do
  def sha256(salt, pass) do
    hash = :crypto.hmac(:sha256, salt, pass)
    Base.encode16(hash, case: :lower)
  end
end

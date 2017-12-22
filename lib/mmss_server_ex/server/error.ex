defmodule MMSSServer.Server.Error do
  def errInvalidParams, do: 1
  def errLoginFailure, do: 2
  def errAuthorizationRequired, do: 3
  def errRouteNotFound, do: 4
end

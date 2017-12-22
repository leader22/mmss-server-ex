defmodule MMSSServer.Server.Error do
  @moduledoc """
  Constants for SERVER error to handle it in CLIENT
  """

  def err_invalid_params, do: 1
  def err_login_failure, do: 2
  def err_authorization_required, do: 3
  def err_route_not_found, do: 4
end

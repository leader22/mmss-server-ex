defmodule MMSSServer.Server.Error do
  @moduledoc """
  Constants for SERVER error to handle it in CLIENT
  """

  @spec err_invalid_params() :: 1
  def err_invalid_params, do: 1

  @spec err_login_failure() :: 2
  def err_login_failure, do: 2

  @spec err_authorization_required() :: 3
  def err_authorization_required, do: 3

  @spec err_route_not_found() :: 4
  def err_route_not_found, do: 4
end

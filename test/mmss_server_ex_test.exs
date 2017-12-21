defmodule MMSSServerTest do
  use ExUnit.Case
  doctest MMSSServer

  test "greets the world" do
    assert MMSSServer.hello() == :world
  end
end

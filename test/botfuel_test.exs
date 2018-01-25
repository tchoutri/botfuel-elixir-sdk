defmodule BotfuelTest do
  use ExUnit.Case
  doctest Botfuel

  test "greets the world" do
    assert Botfuel.hello() == :world
  end
end

defmodule EnjoybotTest do
  use ExUnit.Case
  doctest Enjoybot

  test "greets the world" do
    assert Enjoybot.hello() == :world
  end
end

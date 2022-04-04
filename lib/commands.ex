defmodule Enjoybot.Commands do
  use Alchemy.Cogs

  Cogs.def status do
    Cogs.say(:alive)
  end
end

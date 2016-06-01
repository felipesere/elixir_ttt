defmodule Main do
  def main(args) do
    first  = Human.create(:x, Display)
    second = Ai.create(:o)

    Game.create(first, second)
    |> Game.play
  end
end

defmodule GameTest do
  use ExUnit.Case

  test "swaps players on turn" do
    [first, second] = create_players
    game = Game.create(first, second)

    %{players: players} =  game |> Game.turn
    assert players == [second, first]
  end

  defp create_players() do
    [
      Human.create(marker: :x, io: NotTheRealDisplay),
      Ai.create(marker: :o)
    ]
  end
end


defmodule GameTest do
  use ExUnit.Case

  test "swaps players on turn" do
    [first, second] = create_players

    %Game{players: players} =  Game.create(first, second) |> Game.turn
    assert players == [second, first]
  end

  test "plays until there is a winner" do
    [first, second] = [
                        ScriptablePlayer.create(marker: :x, moves: [0,1,2]),
                        ScriptablePlayer.create(marker: :o, moves: [5,6])
                      ]

    %Game{board: board} =  Game.create(first, second) |> Game.play
    assert Board.done?(board)
  end

  defp create_players() do
    [
      Human.create(:x, NotTheRealDisplay),
      Ai.create(:o)
    ]
  end
end

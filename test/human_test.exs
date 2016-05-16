defmodule HumanTest do
  use ExUnit.Case
  import BoardSigil, only: [sigil_b: 2]


  test "can make a move" do
    board = ~b(| | | |
               | | | |
               | | | |)

    human = Human.create(marker: :x, io: NotTheRealDisplay)
    b = Player.make_move(human, board)
    assert b.last_move == 1
  end
end

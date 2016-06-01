defmodule HumanTest do
  use ExUnit.Case
  import BoardSigil, only: [sigil_b: 2]


  test "can make a move" do
    board = ~b(| | | |
               | | | |
               | | | |)

    human = Human.create(:x, NotTheRealDisplay)
    {new_board, _} = Player.make_move(human, board)
    assert new_board.last_move == 1
  end
end

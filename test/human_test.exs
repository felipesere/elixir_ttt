defmodule HumanTest do
  use ExUnit.Case
  import Board, only: [sigil_b: 2]

  defmodule NotTheDisplay do
    def render(board) do
      board
    end

    def get_move(_) do
      1
    end
  end

  test "can make a move" do
    board = ~b(| | | |
               | | | |
               | | | |)

    human = Human.create(:x, io: NotTheDisplay)
    b = human.move.(board)
    assert b.last_move == 1
  end
end

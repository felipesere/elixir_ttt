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

    human = Human.create(marker: :x, io: NotTheDisplay)
    b = Player.make_move(human, board)
    assert b.last_move == 1
  end
end

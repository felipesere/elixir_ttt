defmodule DisplayTest do
  use ExUnit.Case
  
  test "dislpays a board properly" do
    board = Board.create

    expected = "|1|2|3|\n|4|5|6|\n|7|8|9|"

    assert Display.draw(board) == expected
  end
end

defmodule DisplayTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  test "dislpays a board properly" do
    board = Board.create

    expected = "|1|2|3|\n|4|5|6|\n|7|8|9|"

    assert Display.draw(board) == expected
  end

  test "gets an integer move" do
    capture_io("2", fn ->
      send self, Display.get_move
    end)
    move = receive do
      n -> n
    end

    assert move == 2
  end

  test "asks again if input is not a number" do
    output = capture_io("bob\n8", fn ->
      send self, Display.get_move
    end)
    move = receive do
      n -> n
    end

    assert move == 8
    assert String.contains?(output, "Sorry, 'bob' is not a number.")
  end
end

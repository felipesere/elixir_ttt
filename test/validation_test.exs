defmodule ValidationTest do
  use ExUnit.Case
  import BoardSigil, only: [sigil_b: 2]

  test "available location" do
    board = Board.create()

    assert Validation.validate("1", board) == {:ok, 0}
  end

  test "input is not a number" do
    board = ~b"| | | |
               | | | |
               | | | |"

    assert Validation.validate("abc", board) == {:not_a_number, "abc"}
  end

  test "location is already taken" do
    board = ~b"| | | |
               | |x| |
               | | | |"

    assert Validation.validate("5", board) == {:taken, 4}
  end
end

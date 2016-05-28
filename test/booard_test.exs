defmodule BoardTest do
  use ExUnit.Case
  import BoardSigil, only: [sigil_b: 2]

  test "it has nine available moves" do
    board = Board.create()
    assert board |> Board.available_moves |> Enum.count == 9
  end

  test "it knows when a board is not yet done" do
    refute Board.create |> Board.done?
  end

  test "it knows when a board is done for winner" do
    board = ~b"|x|x|x|
               | | | |
               | | | |"
    assert Board.done?(board)
  end

  test "can make a move" do
    initial = ~b"| | | |
                 | | | |
                 | | | |"
    board = Board.make_move(initial, :x, 3)
    assert board |> Board.available_moves |> Enum.count == 8
  end

  test "can find a winner in first column" do
    board = ~b"|x|x|x|
               | | | |
               | | | |"
    assert board |> Board.winner() == :x
  end

  test "can find a winner in a diagonal" do
    board = ~b"|x| | |
               | |x| |
               | | |x|"
    assert board |> Board.winner() == :x
  end

  test "can find a winner in the second diagonal" do
    board = ~b"| | |x|
               | |x| |
               |x| | |"
    assert board |> Board.winner() == :x
  end

  test "does not find a winner if there isn't one" do
    board = ~b"| | |x|
               | | | |
               |x| | |"
    assert board |> Board.winner() == :no_winner
  end

  test "detects a draw" do
    board = ~b"|o|x|x|
               |x|x|o|
               |o|o|x|"
    assert board |> Board.winner() == :draw
  end

  test "creates board based on sigil" do
    board = ~b"|x| |o|
               |x|x| |
               |o| |o|"
    assert board |> Board.available_moves |> Enum.sort == [1,5,7]
  end
end

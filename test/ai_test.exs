defmodule AiTest do
  use ExUnit.Case
  import Board, only: [sigil_b: 2]

  test "it does a simple defense" do
    initial = ~b(|x| | |
                 |o|o| |
                 | | | |)

    result = Ai.move_on(initial, :x)
    assert result.last_move == 5
  end

  test "it does a simple attack" do
    initial = ~b(|x| | |
                 |o|o| |
                 | | | |)

    result = Ai.move_on(initial, :o)
    assert result.last_move == 5
  end

  test "it takes corners" do
    initial = ~b(|o| | |
                 | |o| |
                 | | |x|)
    result = Ai.move_on(initial, :x)
    assert Enum.member?([2,6], result.last_move)
  end

  test "it takes edges" do
    initial = ~b(|o| | |
                 | |x| |
                 | | |o|)
    result = Ai.move_on(initial, :x)
    assert Enum.member?([1, 3, 5, 7], result.last_move)
  end

  test "it scores a win with positive points" do
    board = ~b"| | | |
               |o|o|o|
               | | | |"
    assert Ai.score(board, :o) == 6
  end

  test "it scores a loss with negative points" do
    board = ~b"| | | |
               |x|x|x|
               | | | |"
    assert Ai.score(board, :o) == -6
  end

  test "it scores a draw with zero points" do
    board = ~b"|o|x|x|
               |x|x|o|
               |o|o|x|"
    assert Ai.score(board, :o) == 0
  end
end
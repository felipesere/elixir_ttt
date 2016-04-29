defmodule BoardTest do
  use ExUnit.Case

  test "it has nine available moves" do
    board = Board.create()
    assert board |> Board.available_moves |> Enum.count == 9
  end

  test "can make a move" do
    board = Board.create() |> Board.make_move(:x, 3)
    assert board |> Board.available_moves |> Enum.count == 8
  end

  test "can find a winner in first row" do
    board = Board.create() |> make_moves([0, 1,2], :x)
    assert board |> Board.winner == :x
  end

  test "can find a winner in first column" do
    board = Board.create() |> make_moves([0, 3,6], :x)
    assert board |> Board.winner == :x
  end

  test "can find a winner in a diagonal" do
    board = Board.create() |> make_moves([0, 4,8], :x)
    assert board |> Board.winner == :x
  end

  test "does not find a winner if there isn't one" do
    board = Board.create() |> make_moves([0, 1], :x)
    assert board |> Board.winner == :no_winner
  end

  test "it knows who won" do
    board = Board.create() |> make_moves([0, 1, 2], :x)
    assert board |> Board.winner == :x
  end

  def make_moves(board, moves, mark) do
    Enum.reduce(moves, board, &(Board.make_move(&2, mark, &1)))
  end
end

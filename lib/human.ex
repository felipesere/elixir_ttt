defmodule Human do
  defstruct [:io, :move]

  def create(marker, [io: io]) do
    %Human{io: io, move: fn(board) -> move_on(board, marker, io) end}
  end

  def move_on(board, marker, io) do
    move = get_move(board, io)

    Board.make_move(board, marker, move)
  end

  defp get_move(board, io) do
    board
    |> io.get_move
    |> validate(board, io)
  end

  defp validate(move, board, io) do
    moves = board |> Board.available_moves

    cond do
      move in moves -> move
      true -> get_move(board, io)
    end
  end
end

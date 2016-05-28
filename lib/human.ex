defmodule Human do
  defstruct [:io, :marker]

  def create([marker: marker, io: io]) do
    %Human{io: io, marker: marker}
  end
end

defimpl Player, for: Human do

  def make_move(%Human{marker: marker, io: io} = human, board) do
    case get_move(board, io) do
      {:ok, move} -> Board.make_move(board, marker, move)
      _ -> make_move(human, board)
    end
  end

  defp get_move(board, io) do
    io.get_move
    |> validate(board)
  end

  defp validate(move, board) do
    moves = board |> Board.available_moves

    cond do
      move in moves -> {:ok, move}
      true -> :invalid
    end
  end
end

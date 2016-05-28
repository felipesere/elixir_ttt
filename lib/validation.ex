defmodule Validation do
  def validate(move, board) do
    move
    |> number
    |> available(board)
  end

  defp number(move) do
    case Integer.parse(move) do
      {n, ""} -> n - 1
      _ -> {:not_a_number, move}
    end
  end

  defp available(move, board) when is_integer(move) do
    if move in Board.available_moves(board) do
      {:ok, move}
    else
      {:taken, move}
    end
  end
  defp available(error, _), do: error
end

defmodule Ai do
  def move_on(board, marker) do
    {move, _} = minimax(board, marker)
    Board.make_move(board, marker, move)
  end

  def minimax(board, marker) do
    move = Board.last_move(board)

    if Board.done?(board) do
      {move, score(board, marker)}
    else
      Enum.reduce(Board.available_moves(board), {-1, -100}, fn(move, acc) ->
        next = Board.make_move(board, marker, move)
        {_, score} = minimax(next, opponent(marker)) |> negate
        {best_move, best_score} = acc

        if best_score >= score do
          {best_move, best_score}
        else
          {move, score}
        end
      end)
    end
  end

  defp negate({move, score}), do: {move, -score}

  defp opponent(:x), do: :o
  defp opponent(:o), do: :x

  def score(board, mark) do
    case Board.winner(board) do
      ^mark -> count_moves(board)
      :draw -> 0
      :no_winner -> raise "How did we get here?"
      _ -> -count_moves(board)
    end
  end

  defp count_moves(board), do: length(Board.available_moves(board))
end

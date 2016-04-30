defmodule Ai do
  def move_on(board, marker) do
    {move, _alpha, _beta} = minimax(board, marker)
    Board.make_move(board, marker, move)
  end

  def minimax(board, mark), do: minimax(board, mark, -100, 100)
  def minimax(board, marker, alpha, beta) do
    move = Board.last_move(board)

    if Board.done?(board) do
      {move, score(board, marker), beta}
    else
      Enum.reduce_while(Board.available_moves(board), {-1, alpha, beta}, fn(move, acc) ->
        next = Board.make_move(board, marker, move)
        {_, score, _beta} = minimax(next, opponent(marker), -beta, -alpha) |> negate

        {best_move, best_score, current_beta} = acc

        gamma = max(alpha, score)

        if gamma > beta do
          {:halt, {move, score, beta}}
        else
          if best_score >= score do
            {:cont, {best_move, best_score, current_beta}}
          else
            {:cont, {move, score, beta}}
          end
        end
      end)
    end
  end

  defp negate({move, score, b}), do: {move, -score, b}

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

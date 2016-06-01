defmodule Ai do
  defstruct [:marker]

  def create(marker), do: %Ai{marker: marker}
end

defimpl Player, for: Ai do
  def make_move(%Ai{marker: marker} = ai, board), do: {move_on(board, marker), ai}

  def move_on(board, marker) do
    {move, _, _} = minimax(board, marker)
    Board.make_move(board, marker, move)
  end

  def minimax(board, mark), do: minimax(board, mark, -100, 100)
  def minimax(board, marker, alpha, beta) do
    move = Board.last_move(board)

    if Board.done?(board) do
      {move, score(board, marker), beta}
    else
      heuristic(board, marker, alpha, beta)
    end
  end

  defp heuristic(board, marker, alpha, beta) do
    board
    |> Board.available_moves
    |> Enum.reduce_while({-1, alpha, beta}, &( find_best_move(board, &1, marker, &2)))
  end

  defp  find_best_move(board, move, marker, {_, alpha, beta} = acc) do
    score = score_unfinished(board, marker, move, alpha, beta)
    potential = {move, score, beta}

    cond do
      max(alpha, score) > beta -> {:halt, potential}
      alpha >= score -> {:cont, acc}
      true -> {:cont, potential}
    end
  end

  defp score_unfinished(board, marker, move, alpha, beta) do
    board
    |> Board.make_move(marker, move)
    |> minimax(opponent(marker), -beta, -alpha)
    |> negate
    |> elem(1)
  end

  defp negate({move, score, b}), do: {move, -score, b}

  defp opponent(:x), do: :o
  defp opponent(:o), do: :x

  def score(board, mark) do
    case Board.winner(board) do
      ^mark -> count_moves(board)
      :draw -> 0
      _ -> -count_moves(board)
    end
  end

  defp count_moves(board), do: length(Board.available_moves(board))
end

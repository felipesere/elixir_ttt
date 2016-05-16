defmodule Board do
  defstruct elements: [], last_move: nil

  def create(), do: create(3)
  def create(elements) when is_list(elements) do
    %Board{ elements: elements, last_move: nil}
  end
  def create(dimension) do
    elements = for x <- 1..dimension*dimension, do: x
    %Board{ elements: elements, last_move: nil }
  end

  def last_move(%Board{ last_move: m}), do: m

  def available_moves(%Board{ elements: elements}), do: available_moves(elements)
  def available_moves(elements) do
    elements
    |> Enum.filter(&remove_marks/1)
    |> Enum.shuffle
  end

  defp remove_marks(:x), do: false
  defp remove_marks(:o), do: false
  defp remove_marks(_), do: true

  def winner(%Board{ elements: elements}) do
    elements
    |> lines()
    |> Enum.find(:no_winner, &all_same?/1)
    |> extract_winner
    |> detect_draw(elements)
  end

  defp extract_winner([mark,_,_]), do: mark
  defp extract_winner(other), do: other

  defp detect_draw(:no_winner, elements) do
    if moves_left?(elements) do
      :no_winner
    else
      :draw
    end
  end
  defp detect_draw(winner, _), do: winner

  defp moves_left?(elements) do
    length(available_moves(elements)) > 0
  end

  def has_winner?(%Board{ elements: elements }) do
    elements
    |> lines()
    |> Enum.any?(&all_same?/1)
  end

  defp has_draw?(board) do
    board |> available_moves |> length == 0
  end

  def done?(board), do: has_winner?(board) || has_draw?(board)

  defp lines(elements) do
    rows(elements) ++ colums(elements) ++ diagonals(elements)
  end

  def rows(%Board{elements: elements}), do: rows(elements)
  def rows(elements), do: Enum.chunk(elements, 3)

  defp colums(elements) do
    elements
    |> rows
    |> transpose
  end

  def transpose([[]|_]), do: []
  def transpose(a), do: [Enum.map(a, &hd/1) | transpose(Enum.map(a, &tl/1))]

  def diagonals(x) do
    row = x |> rows
    first =   row |> diagonal
    second =  row |> reverse |> diagonal

    [first, second]
  end

  defp reverse(elements), do: Enum.map(elements, &Enum.reverse/1)

  defp diagonal(elements) do
    elements
    |> Enum.with_index
    |> Enum.map(fn({line, index}) -> Enum.at(line, index) end)
  end

  defp all_same?([nil, _,_]), do: false
  defp all_same?([a,a,a]), do: true
  defp all_same?(_), do: false

  def make_move(%Board{ elements: elements}, marker, move) do
    %Board{ last_move: move, elements: List.update_at(elements, move, fn(n) -> marker end) }
  end
end

defmodule Board do
  defstruct elements: []

  def create(dimension \\ 3) do
    elements = for x <- 1..dimension*dimension, do: nil
    %Board{ elements: elements }
  end

  def available_moves(%Board{ elements: elements}) do
    elements
    |> Enum.with_index
    |> Enum.filter(&keep_empties/1)
    |> Enum.map(&just_index/1)
  end

  def winner(%Board{ elements: elements}) do
    elements
    |> lines()
    |> Enum.find(:no_winner, &all_same?/1)
    |> extract_winner
  end

  defp extract_winner([mark,_,_]), do: mark
  defp extract_winner(other), do: other

  def has_winner?(%Board{ elements: elements }) do
    elements
    |> lines()
    |> Enum.any?(&all_same?/1)
  end

  defp lines(elements) do
    rows(elements) ++ colums(elements) ++ diagonals(elements)
  end

  defp rows(elements), do: Enum.chunk(elements, 3)
  defp colums(elements) do
    elements
    |> rows
    |> transpose
  end

  def transpose([[]|_]), do: []
  def transpose(a) do
    [Enum.map(a, &hd/1) | transpose(Enum.map(a, &tl/1))]
  end

  defp diagonals([a, _, b,
                  _, c, _,
                  d, _, e]) do
     [ [a,c,e], [b, c, d] ]
  end

  defp all_same?([nil, _,_]), do: false
  defp all_same?([a,a,a]), do: true
  defp all_same?(_), do: false

  defp keep_empties({nil, _}), do: true
  defp keep_empties(_), do: false

  defp just_index({_, index}), do: index

  def make_move(%Board{ elements: elements}, marker, move) do
    %Board{ elements: List.update_at(elements, move, fn(_) -> marker end) }
  end
end

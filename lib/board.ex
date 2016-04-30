defmodule Board do
  defstruct elements: [], last_move: nil

  def create(), do: create(3)
  def create(elements) when is_list(elements) do
    %Board{ elements: elements, last_move: nil}
  end
  def create(dimension) do
    elements = for _ <- 1..dimension*dimension, do: nil
    %Board{ elements: elements, last_move: nil }
  end

  def last_move(%Board{ last_move: m}), do: m

  def available_moves(%Board{ elements: elements}), do: available_moves(elements)
  def available_moves(elements) do
    elements
    |> Enum.with_index
    |> Enum.filter(&keep_empties/1)
    |> Enum.map(&just_index/1)
    |> Enum.shuffle
  end

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

  defp rows(elements), do: Enum.chunk(elements, 3)

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

  defp keep_empties({nil, _}), do: true
  defp keep_empties(_), do: false

  defp just_index({_, index}), do: index

  def make_move(%Board{ elements: elements}, marker, move) do
    %Board{ last_move: move, elements: List.update_at(elements, move, fn(_) -> marker end) }
  end

  def sigil_b(string,_opts) do
    string
    |> String.split("\n")
    |> Enum.map(&String.strip/1)
    |> Enum.flat_map(&parse/1)
    |> Board.create
  end

  defp parse(string), do: parse(string, [])
  defp parse("|", acc), do: Enum.reverse(acc)
  defp parse(<<"|", element :: binary-size(1)>> <> remainder, acc) do
    parse(remainder, [convert(element) | acc])
  end

  defp convert("x"), do: :x
  defp convert("o"), do: :o
  defp convert(_), do: nil
end

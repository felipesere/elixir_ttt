defmodule Display do
  def render(board) do
    board
    |> draw
    |> IO.puts

    board
  end

  def get_move(board) do
    move = read_move

    case Validation.validate(move, board) do
      {:ok, m} -> m
      {:not_a_number, move}  -> was_not_a_number(move, board)
      {:taken, _}  -> location_already_taken(move, board)
    end
  end

  defp read_move do
    IO.gets("What move do you want to make?\n>")
    |> String.strip
  end

  defp was_not_a_number(move, board) do
    IO.puts("Sorry, '#{move}' is not a number.")
    get_move(board)
  end
  defp location_already_taken(move, board) do
    IO.puts("Sorry, move '#{move}' is already taken.")
    get_move(board)
  end

  def draw(board) do
    board
    |> Board.rows
    |> Enum.map(&draw_row/1)
    |> Enum.join("\n")
  end

  defp draw_row(elements) do
    elements
    |> Enum.map(fn (x) when is_integer(x) -> x+1
                   (x) -> x end)
    |> Enum.join("|")
    |> with_borders
  end

  defp with_borders(line), do: "|" <> line <> "|"
end

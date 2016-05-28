defmodule Display do

  def render(board) do
    board
    |> draw
    |> IO.puts

    board
  end

  def get_move() do
    IO.gets("What move do you want to make?\n>")
    |> String.strip
    |> validate
    |> message
  end

  defp validate(move) do
    case Integer.parse(move) do
      {n, ""} -> n
      _ -> {:not_a_number, move}
    end
  end

  def message({:not_a_number, move}) do
    IO.puts("Sorry, '#{move}' is not a number.")
    get_move
  end
  def message(n), do: n

  def draw(board) do
    board
    |> Board.rows
    |> Enum.map(&draw_row/1)
    |> Enum.join("\n")
  end

  defp draw_row(elements) do
    line = Enum.join(elements, "|")
    "|" <> line <> "|"
  end
end

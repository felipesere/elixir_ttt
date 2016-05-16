defmodule Display do

  def render(board) do
    board
    |> draw
    |> IO.puts

    board
  end

  def get_move(_) do
    3
  end

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

defmodule Game do
  defstruct players: [], board: nil

  def create(player_1, player_2) do
    %Game{ players: [player_1, player_2], board: Board.create}
  end

  def turn(%Game{ players: [first, second], board: board}) do
    new_board = first.move(board)

    %Game{ players: [second, first], board: new_board}
  end

  defp over?(%Game{board: board}) do
    Board.has_winner?(board) || Board.has_draw?(board)
  end
end

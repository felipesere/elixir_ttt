defmodule Game do
  defstruct players: [], board: Board.create

  def create(player_1, player_2) do
    %Game{ players: [player_1, player_2], board: Board.create}
  end

  def turn(%Game{ players: [first, second], board: board}) do
    {new_board, player} = Player.make_move(first, board)

    %Game{ players: [second, player], board: new_board}
  end

  def play(game) do
    if over?(game) do
      game
    else
      game
      |> turn
      |> play
    end
  end

  defp over?(%Game{board: board}), do: Board.done?(board)
end

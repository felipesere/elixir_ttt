defmodule ScriptablePlayer do
  defstruct [:marker, :moves]

  def create(marker: marker, moves: moves) do
    %ScriptablePlayer{marker: marker, moves: moves}
  end
end

defimpl Player, for: ScriptablePlayer do

  def make_move(%ScriptablePlayer{moves: []}, _) do
    {:error, :no_moves_left}
  end

  def make_move(player = %ScriptablePlayer{marker: marker, moves: [move | rest]}, board) do
    {Board.make_move(board, marker, move), %{ player | moves: rest}}
  end
end

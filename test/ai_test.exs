defmodule AiTest do
  use ExUnit.Case
  import BoardSigil, only: [sigil_b: 2]

  @ai Ai.create(:x)

  test "it does a simple defense" do
    initial = ~b(|x| | |
                 |o|o| |
                 | | | |)

    {result, _} = Player.make_move(@ai, initial)
    assert result.last_move == 5
  end

  test "it does a simple attack" do
    initial = ~b(|x| | |
                 |o|o| |
                 | | | |)

    {result, _} = Player.make_move(@ai, initial)
    assert result.last_move == 5
  end

  test "it takes corners" do
    initial = ~b(|o| | |
                 | |o| |
                 | | |x|)
    {result, _} = Player.make_move(@ai, initial)
    assert Enum.member?([2,6], result.last_move)
  end

  test "it takes edges" do
    initial = ~b(|o| | |
                 | |x| |
                 | | |o|)
    {result, _} = Player.make_move(@ai, initial)
    assert Enum.member?([1, 3, 5, 7], result.last_move)
  end
end

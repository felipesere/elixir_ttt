defmodule DisplayTest do
  use ExUnit.Case
  import ExUnit.CaptureIO
  import BoardSigil, only: [sigil_b: 2]

  @empty_board ~b(| | | |
                  | | | |
                  | | | |)

  test "dislpays a board properly" do
    assert Display.draw(@empty_board) == "|1|2|3|\n|4|5|6|\n|7|8|9|"
  end

  test "gets an integer move" do
    {move, output} = capture("2", fn -> Display.get_move(@empty_board) end)

    assert move == 1
    assert output =~ "What move do you want to make?"
  end

  test "asks again if input is not a number" do
    {move, output} = capture("bob\n8", fn -> Display.get_move(@empty_board) end)

    assert move == 7
    assert output =~ "Sorry, 'bob' is not a number."
  end

  test "asks again if location already taken" do
    board = ~b(|x| | |
               | | | |
               | | | |)

    {move, output} = capture("1\n5", fn -> Display.get_move(board) end)
    assert move == 4
    assert output =~ "Sorry, move '1' is already taken"
  end

  def capture(input \\ "", function) do
    output = capture_io(input, fn ->
      send self, function.()
    end)
    result = receive do
      n -> n
    end

    {result, output}
  end
end

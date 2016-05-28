defmodule DisplayTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  test "dislpays a board properly" do
    board = Board.create

    assert Display.draw(board) == "|1|2|3|\n|4|5|6|\n|7|8|9|"
  end

  test "gets an integer move" do
    {move, _} = capture("2", &Display.get_move/0)

    assert move == 2
  end

  test "asks again if input is not a number" do
    {move, output} = capture("bob\n8", &Display.get_move/0)

    assert move == 8
    assert output =~ "Sorry, 'bob' is not a number."
  end

  test "asks after invalid move" do
    {move, output} = capture("8", fn -> Display.get_move({:invalid, 37}) end)

    assert move == 8
    assert output =~ "'37' is already taken."
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

defmodule BoardSigil do
  def sigil_b(string,_opts) do
    string
    |> to_list
    |> Enum.with_index
    |> Enum.map(&parse/1)
    |> Board.create
  end

  def to_list(string) do
    string
    |> String.split("\n")
    |> Enum.map(&String.strip/1)
    |> Enum.flat_map(&(String.split(&1,"|")))
    |> Enum.reject(&(&1 == ""))
  end

  defp parse({" ", idx}), do: idx
  defp parse({mark, _}), do: String.to_atom(mark)
end

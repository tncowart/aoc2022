defmodule Day6 do
  @input File.open!("day6.input", encoding: :utf8)
         |> IO.read(:eof)
         |> String.to_charlist()

  def find_marker(size) do
    @input
    |> Enum.chunk_every(size, 1)
    |> Enum.with_index(size)
    |> Enum.drop_while(fn {x, _} ->
      size !=
        Enum.sort(x)
        |> Enum.dedup()
        |> length()
    end)
    |> List.first()
    |> elem(1)
  end

  def part1(), do: find_marker(4)
  def part2(), do: find_marker(14)
end

Day6.part1() |> IO.puts()
Day6.part2() |> IO.puts()

defmodule Day1 do
  @input File.stream!("day1.input", [encoding: :utf8], :line)
         |> Stream.map(&(String.trim(&1)))
         |> Stream.chunk_by(&(&1 != ""))
         |> Stream.reject(&(&1 == [""]))
         |> Stream.map(fn x -> Enum.sum(Enum.map(x, &(String.to_integer(&1)))) end)
         |> Enum.into([])

  def part1() do
    @input
    |> Enum.max()
  end

  def part2() do
    @input
    |> Enum.sort(:desc)
    |> Enum.take(3)
    |> Enum.sum()
  end
end

Day1.part1() |> IO.puts()
Day1.part2() |> IO.puts()

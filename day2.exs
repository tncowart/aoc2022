defmodule Day2 do
  @input File.stream!("day2.input", [encoding: :utf8], :line)
         |> Stream.map(&String.trim(&1))
         |> Enum.into([])

  def part1() do
    @input
    |> Enum.map(fn x ->
      case x do
        "A X" -> 4
        "A Y" -> 8
        "A Z" -> 3
        "B X" -> 1
        "B Y" -> 5
        "B Z" -> 9
        "C X" -> 7
        "C Y" -> 2
        "C Z" -> 6
      end
    end)
    |> Enum.sum()
  end

  def part2() do
    @input
    |> Enum.map(fn x ->
      case x do
        "A X" -> 3
        "A Y" -> 4
        "A Z" -> 8
        "B X" -> 1
        "B Y" -> 5
        "B Z" -> 9
        "C X" -> 2
        "C Y" -> 6
        "C Z" -> 7
      end
    end)
    |> Enum.sum()
  end
end

Day2.part1() |> IO.puts()
Day2.part2() |> IO.puts()

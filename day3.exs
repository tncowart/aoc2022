defmodule Day3 do
  @input File.stream!("day3.input", [encoding: :utf8], :line)
         |> Enum.map(&String.trim/1)
         |> Enum.map(&String.to_charlist/1)
         |> Enum.into([])

  def part1() do
    @input
    |> Enum.map(&Enum.split(&1, div(length(&1), 2)))
    |> Enum.map(fn {x, y} -> MapSet.intersection(MapSet.new(x), MapSet.new(y)) end)
    |> priority_sum()
  end

  def part2() do
    @input
    |> Enum.map(&MapSet.new/1)
    |> Enum.chunk_every(3)
    |> Enum.map(fn [a, b, c] ->
      MapSet.intersection(MapSet.intersection(a, b), c)
    end)
    |> priority_sum()
  end

  defp priority_sum(x) do
    x
    |> Enum.map(&MapSet.to_list/1)
    |> Enum.map(&List.first/1)
    |> Enum.map(&priority/1)
    |> Enum.sum()
  end

  defp priority(x) when x < 91, do: x - 38
  defp priority(x), do: x - 96
end

Day3.part1() |> IO.puts()
Day3.part2() |> IO.puts()

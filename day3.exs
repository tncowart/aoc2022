defmodule Day3 do
  @input File.stream!("day3.input", [encoding: :utf8], :line)
         |> Enum.map(&(String.trim(&1)))
         |> Enum.into([])

  def part1() do
    @input
    |> Enum.map(&(String.split_at(&1, div(String.length(&1), 2) + rem(String.length(&1), 2))))
    |> Enum.map(fn {x, y} -> {MapSet.new(String.to_charlist(x)), MapSet.new(String.to_charlist(y))} end)
    |> Enum.map(fn {x, y} -> MapSet.intersection(x, y) end)
    |> Enum.map(&(MapSet.to_list(&1)))
    |> Enum.map(&(List.first(&1)))
    |> Enum.map(&(if &1 < 91 do
      &1 - 38
    else
      &1 - 96
    end))
    |> Enum.sum()
  end

  def part2() do
    @input
    |> Enum.map(&(String.to_charlist(&1)))
    |> Enum.map(&(MapSet.new(&1)))
    |> Enum.chunk_every(3)
    |> Enum.map(fn [a, b, c] ->
      MapSet.intersection(MapSet.intersection(a, b), c)
    end)
    |> Enum.map(&(MapSet.to_list(&1)))
    |> Enum.map(&(List.first(&1)))
    |> Enum.map(&(if &1 < 91 do
      &1 - 38
    else
      &1 - 96
    end))
    |> Enum.sum()
  end
end


Day3.part1() |> IO.puts()
Day3.part2() |> IO.puts()

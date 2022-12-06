defmodule Day6 do
  @input File.open!("day6.input", [encoding: :utf8])
         |> IO.read(:eof)
         |> String.to_charlist()



  def part1() do
    @input
    |> Enum.chunk_every(4, 1)
    |> Enum.with_index(4)
    |> Enum.drop_while(fn {x, _} ->
      4 != Enum.sort(x)
      |> Enum.dedup()
      |> length()
    end)
    |> List.first()
    |> elem(1)
  end

  def part2() do
    @input
    |> Enum.chunk_every(14, 1)
    |> Enum.with_index(14)
    |> Enum.drop_while(fn {x, _} ->
      14 != Enum.sort(x)
      |> Enum.dedup()
      |> length()
    end)
    |> List.first()
    |> elem(1)
  end

end

Day6.part1() |> IO.puts()
Day6.part2() |> IO.puts()

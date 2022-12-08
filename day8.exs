defmodule Day8 do
  @input_h File.stream!("day8.input", [encoding: :utf8], :line)
           |> Enum.map(&String.to_charlist/1)
           |> Enum.map(fn x -> Enum.map(x, &(&1 - ?0)) end)

  @input_hr File.stream!("day8.input", [encoding: :utf8], :line)
           |> Enum.map(&String.to_charlist/1)
           |> Enum.map(&Enum.reverse/1)
           |> Enum.map(fn x -> Enum.map(x, &(&1 - ?0)) end)

  @input_v Enum.zip(File.stream!("day8.input", [encoding: :utf8], :line)
           |> Enum.map(&String.to_charlist/1)
           |> Enum.map(fn x -> Enum.map(x, &(&1 - ?0)) end))
           |> Enum.map(&Tuple.to_list/1)

  @input_vr Enum.zip(File.stream!("day8.input", [encoding: :utf8], :line)
           |> Enum.map(&String.to_charlist/1)
           |> Enum.map(&Enum.reverse/1)
           |> Enum.map(fn x -> Enum.map(x, &(&1 - ?0)) end))
           |> Enum.map(&Tuple.to_list/1)

  def compute_visibility([head | tail]) do

  end
  def compute_visibility([tail]) do
    Enum.map(tail, 1)
  end

  def part1() do
    @input_h
  end
  def part2() do

  end
end

Day8.part1() |> IO.inspect()
Day8.part2() |> IO.inspect()

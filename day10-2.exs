defmodule Day10 do
  def op2list("noop"), do: [0]
  def op2list(op), do: [0, String.split(op) |> List.last() |> String.to_integer()]

  def calc_pixel(step, x) when rem(step, 40) in (x - 1)..(x + 1), do: '#'
  def calc_pixel(_step, _x), do: ' '

  def part1(vals), do: 20..220//40 |> Enum.map(&(Enum.at(vals, &1 - 1) * &1)) |> Enum.sum()
  def part2(vals), do: 0..240 |> Enum.map(&calc_pixel(&1, Enum.at(vals, &1)))
end

val_list =
  File.stream!("day10.input", [encoding: :utf8], :line)
  |> Stream.map(&String.trim/1)
  |> Enum.to_list()
  |> Enum.reduce([1], &(&2 ++ Day10.op2list(&1)))
  |> Enum.scan(&(&1 + &2))

Day10.part1(val_list) |> IO.puts()
Day10.part2(val_list) |> Enum.chunk_every(40) |> Enum.reduce(&(&2 ++ ["\n"] ++ &1)) |> IO.puts()

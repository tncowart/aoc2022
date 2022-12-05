defmodule Day4 do
  @input File.stream!("day4.input", [encoding: :utf8], :line)
         |> Stream.map(&tl(Regex.run(~r/(\d+)-(\d+),(\d+)-(\d+)/, &1)))
         |> Stream.map(&Enum.map(&1, fn x -> String.to_integer(x) end))
         |> Enum.into([])

  def part1() do
    @input
    |> Enum.count(fn [a, b, x, y] ->
      case Enum.sort([a, b, x, y]) do
        [^a, ^x, ^y, ^b] -> true
        [^x, ^a, ^b, ^y] -> true
        _ -> false
      end
    end)
  end

  def part2() do
    @input
    |> Enum.count(fn [a, b, x, y] ->
      case Enum.sort([a, b, x, y]) do
        [^a, ^b, ^x, ^y] when b != x -> false
        [^x, ^y, ^a, ^b] when y != a -> false
        _ -> true
      end
    end)
  end
end

Day4.part1() |> IO.puts()
Day4.part2() |> IO.puts()

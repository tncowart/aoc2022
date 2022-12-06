defmodule Day5 do
  @boxes File.stream!("day5.input", [encoding: :utf8], :line)
         |> Enum.take(8)
         |> Enum.map(&tl(String.to_charlist(&1)))
         |> Enum.map(&Enum.take_every(&1, 4))
         |> Enum.reduce(
           [[], [], [], [], [], [], [], [], []],
           &Enum.zip_with(&1, &2, fn x, a -> if x == 32, do: a, else: [x | a] end)
         )
         |> Enum.map(&Enum.reverse/1)

  @moves File.stream!("day5.input", [encoding: :utf8], :line)
         |> Enum.drop(10)
         |> Enum.map(&tl(Regex.run(~r/move (\d+) from (\d+) to (\d+)/, &1)))
         |> Enum.map(fn [x, y, z] -> [String.to_integer(x), String.to_integer(y) - 1, String.to_integer(z) - 1] end)

  def move_boxes(how) do
    @moves
    |> Enum.reduce(@boxes, fn [ct, from, to], a ->
      {top, new_from_list} = Enum.split(Enum.at(a, from), ct)
      x = List.replace_at(a, from, new_from_list)
      List.replace_at(x, to, how.(top) ++ Enum.at(a, to))
    end)
    |> Enum.map(&List.first/1)
  end

  def part1(), do: move_boxes(&Enum.reverse/1)
  def part2(), do: move_boxes(&(&1))
end

Day5.part1() |> IO.puts()
Day5.part2() |> IO.puts()

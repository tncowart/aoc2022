defmodule Day11 do
  def add_item(monkies, i, item) do
    old_monkey = Enum.at(monkies, i)
    List.replace_at(monkies, i, %{old_monkey | items: old_monkey[:items] ++ [item]})
  end

  def set_items(monkies, i, items) do
    List.replace_at(monkies, i, %{Enum.at(monkies, i) | items: items})
  end

  def calc_inspections(input, mod, megamod) do
    0..(length(input) - 1)
    |> Enum.reduce({[], input}, fn i, {inspections, monkies}  ->
      monkey = Enum.at(monkies, i)

      new_monkies = monkey[:items] |> Enum.reduce(monkies, fn item, ms ->
        worry = rem(div(monkey[:op].(item), mod), megamod)
        add_item(ms, monkey[:next_monkey].(worry), worry)
      end)

      {[length(monkey[:items]) | inspections], set_items(new_monkies, i, [])}
    end)
  end

  def part(input, iters, mod) do
    megamod = input |> Enum.map(fn x-> x[:test] end) |> Enum.product()
    2..iters
    |> Enum.reduce(calc_inspections(input, mod, megamod), fn _, {counts, monkies} ->
      {new_counts, new_monkies} = calc_inspections(monkies, mod, megamod)
      {Enum.zip(counts, new_counts) |> Enum.map(&Tuple.sum/1), new_monkies}
    end)
    |> elem(0)
    |> Enum.sort(:desc)
    |> Enum.take(2)
    |> Enum.product()
  end

  def part1(input), do: part(input, 20, 3)
  def part2(input), do: part(input, 10000, 1)
end

monkies = [
  %{items: [56, 56, 92, 65, 71, 61, 79], op: &(&1 * 7), test: 3, next_monkey: &(if rem(&1, 3) == 0, do: 3, else: 7)},
  %{items: [61, 85], op: &(&1 + 5), test: 11, next_monkey: &(if rem(&1, 11) == 0, do: 6, else: 4)},
  %{items: [54, 96, 82, 78, 69], op: &(&1 * &1), test: 7, next_monkey: &(if rem(&1, 7) == 0, do: 0, else: 7)},
  %{items: [57, 59, 65, 95], op: &(&1 + 4), test: 2, next_monkey: &(if rem(&1, 2) == 0, do: 5, else: 1)},
  %{items: [62, 67, 80], op: &(&1 * 17), test: 19, next_monkey: &(if rem(&1, 19) == 0, do: 2, else: 6)},
  %{items: [91], op: &(&1 + 7), test: 5, next_monkey: &(if rem(&1, 5) == 0, do: 1, else: 4)},
  %{items: [79, 83, 64, 52, 77, 56, 63, 92], op: &(&1 + 6), test: 17, next_monkey: &(if rem(&1, 17) == 0, do: 2, else: 0)},
  %{items: [50, 97, 76, 96, 80, 56], op: &(&1 + 3), test: 13, next_monkey: &(if rem(&1, 13) == 0, do: 3, else: 5)},
]

Day11.part1(monkies) |> IO.inspect()
Day11.part2(monkies) |> IO.inspect()

defmodule Day10 do
  @input File.stream!("day10.input", [encoding: :utf8], :line)
         |> Stream.map(&String.trim/1)
         |> Enum.to_list()

  @check_steps MapSet.new([20, 60, 100, 140, 180, 220])

  def parse_addx(op) do
    [_, amt] = Regex.run(~r/addx (-?\d+)/, op)
    String.to_integer(amt)
  end

  def calc_total(step, x, total) do
    if MapSet.member?(@check_steps, step), do: total + step * x, else: total
  end

  def advance(steps, amt, {step, x, total}) do
    new_total = Enum.reduce(step..(step + steps - 1), total, &calc_total(&1, x, &2))
    {step + steps, x + amt, new_total}
  end

  def part1() do
    @input
    |> Enum.reduce({1, 1, 0}, fn op, {step, x, total} ->
      case op do
        "noop" -> {step + 1, x, calc_total(step, x, total)}
        _ -> advance(2, parse_addx(op), {step, x, total})
      end
    end)
    |> elem(2)
  end

  def calc_pixel(step, x) when rem(step - 1, 40) in (x - 1)..(x + 1), do: '#'
  def calc_pixel(_step, _x), do: ' '

  def part2() do
    @input
    |> Enum.reduce({1, 1, []}, fn op, {step, x, image} ->
      case op do
        "noop" -> {step + 1, x, [calc_pixel(step, x) | image]}
        _ -> {step + 2, x + parse_addx(op), [calc_pixel(step + 1, x), calc_pixel(step, x) | image]}
      end
    end)
    |> elem(2)
    |> Enum.reverse()
  end
end

Day10.part1() |> IO.puts()
Day10.part2()
|> (fn image ->
      Enum.reduce([240, 200, 160, 120, 80, 40], image, fn x, acc ->
        List.insert_at(acc, x, '\n')
      end)
    end).()
|> IO.puts()

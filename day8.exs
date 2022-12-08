defmodule Dists do
  def new(), do: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]

  def blocking_dist(dists, height) do
    dists |> Enum.drop(height) |> Enum.sort() |> List.first()
  end

  def update_dists(dists, curr_height) do
    List.replace_at(Enum.map(dists, &(&1 + 1)), curr_height, 1)
  end
end

defmodule Day8 do
  @input_h File.stream!("day8.input", [encoding: :utf8], :line)
           |> Enum.map(&String.trim/1)
           |> Enum.map(&String.to_charlist/1)
           |> Enum.map(fn x -> Enum.map(x, &(&1 - ?0)) end)

  defp calc_vals(input, calc_fun) do
    h = input |> Enum.map(calc_fun)
    hr = input |> Enum.map(&Enum.reverse/1) |> Enum.map(calc_fun) |> Enum.map(&Enum.reverse/1)
    v = input |> transpose() |> Enum.map(calc_fun) |> transpose()
    vr = input |> transpose() |> Enum.map(&Enum.reverse/1) |> Enum.map(calc_fun) |> Enum.map(&Enum.reverse/1) |> transpose()

    [h, hr, v, vr]
  end

  defp transpose(lists) do
    lists |> Enum.zip() |> Enum.map(&Tuple.to_list/1)
  end

  defp calc_viz(trees) do
    Enum.reduce(trees, {-1, []}, fn y, {max_height, list} -> {max(y, max_height), [ y > max_height | list ]} end)
    |> elem(1)
    |> Enum.reverse()
  end

  def part1() do
    (Enum.zip(calc_vals(@input_h, &calc_viz/1))
    |> Enum.map(fn {w, x, y, z} -> Enum.zip([w, x, y, z]) |> Enum.map(fn {a, b, c, d} -> a or b or c or d end) end)
    |> Enum.map(fn x -> Enum.count(x, &(&1)) end))
    |> Enum.sum()
  end

  defp calc_scene(trees) do
    Enum.reduce(trees, {Dists.new(), []}, fn y, {dists, list} -> {Dists.update_dists(dists, y), [ Dists.blocking_dist(dists, y) | list ]} end)
    |> elem(1)
    |> Enum.reverse()
  end

  def part2() do
    (Enum.zip(calc_vals(@input_h, &calc_scene/1))
    |> Enum.map(fn {w, x, y, z} -> Enum.zip([w, x, y, z]) |> Enum.map(fn {a, b, c, d} -> a * b * c * d end) end)
    |> Enum.map(&Enum.max/1))
    |> Enum.max()
  end
end

Day8.part1() |> IO.puts()
Day8.part2() |> IO.puts()

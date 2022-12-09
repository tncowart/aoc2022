defmodule Day9 do
  @input File.stream!("day9.input", [encoding: :utf8], :line)

  def parse_step(step) do
    [dir, dist] = tl(Regex.run(~r/(\w) (\d+)/, step))
    {dir, String.to_integer(dist)}
  end

  def head_moves({x, y}, {dir, dist}) do
    case dir do
      "R" -> Enum.map(1..dist, &({x + &1, y}))
      "L" -> Enum.map(1..dist, &({x - &1, y}))
      "U" -> Enum.map(1..dist, &({x, y - &1}))
      "D" -> Enum.map(1..dist, &({x, y + &1}))
      _ -> raise "Invalid Step"
    end
  end

  def next_knot_pos({xt, yt}, {xh, yh}) do
    case {xh - xt, yh - yt} do
      {2, 2} -> {xt + 1, yt + 1}
      {2, -2} -> {xt + 1, yt - 1}
      {-2, -2} -> {xt - 1, yt - 1}
      {-2, 2} -> {xt - 1, yt + 1}
      {2, y} ->  {xt + 1, yt + y}
      {-2, y} -> {xt - 1, yt + y}
      {x, 2} -> {xt + x, yt + 1}
      {x, -2} -> {xt + x, yt - 1}
      _ -> {xt, yt}
    end
  end

  def knot_moves(knot, head_moves) do
    Enum.reduce(head_moves, {knot, []}, fn head_pos, {curr_pos, pos_list} ->
      {next_knot_pos(curr_pos, head_pos), [next_knot_pos(curr_pos, head_pos) | pos_list]}
    end)
    |> elem(1)
    |> Enum.reverse()
  end

  def part(length) do
    @input
    |> Enum.map(&parse_step/1)
    |> Enum.reduce({List.duplicate({0, 0}, length), [{0, 0}]}, fn move, {[rope_head, first_knot | rope_tail], old_knot_moves} ->
      new_head_moves = head_moves(rope_head, move)
      new_knot_moves = Enum.reduce(rope_tail, [knot_moves(first_knot, new_head_moves)], &([knot_moves(&1, List.first(&2)) | &2])) |> Enum.reverse()
      {[List.last(new_head_moves) | Enum.map(new_knot_moves, &List.last/1)], old_knot_moves ++ List.last(new_knot_moves)}
    end)
    |> elem(1)
    |> MapSet.new()
    |> MapSet.size()
  end

  def part1(), do: part(2)
  def part2(), do: part(10)
end

Day9.part1() |> IO.puts()
Day9.part2() |> IO.puts()

defmodule Day7 do
  def command_size(command) do
    [_, size, _] = Regex.run(~r/(\d+) (.+)/, command)
    String.to_integer(size)
  end

  def dirname(command) do
    [_, name] = Regex.run(~r/\$ cd (.+)/, command)
    name
  end

  def update_map_size(map, _, []), do: map
  def update_map_size(map, size, [loc_head | loc_tail]) do
    update_map_size(update_in(map[Enum.join([loc_head | loc_tail], "/")], &(&1 + size)), size, loc_tail)
  end

  def build_fs_map([_ | rest]), do: build_fs_map(rest, %{"" => 0}, [""])
  def build_fs_map([], map, _), do: map
  def build_fs_map([command | rest], map, location) do
    cond do
      String.match?(command, ~r/\$ ls/) -> build_fs_map(rest, map, location)
      String.match?(command, ~r/\$ cd \.\./) -> build_fs_map(rest, map, tl(location))
      String.match?(command, ~r/\$ cd .+/) -> build_fs_map(rest, put_in(map[Enum.join([ dirname(command) | location ], "/")], 0), [ dirname(command) | location ])
      String.match?(command, ~r/dir .+/) -> build_fs_map(rest, map, location)
      String.match?(command, ~r/\d+ .+/) -> build_fs_map(rest, update_map_size(map, command_size(command), location), location)
    end
  end

  def part1(fs) do
    Map.values(fs) |> Enum.reduce(0, fn x, acc -> acc + if x < 100000, do: x, else: 0 end)
  end
  def part2(fs) do
    free_space = 70000000 - fs[""]
    (Map.values(fs) |> Enum.map(&(free_space + &1)) |> Enum.filter(&(&1 >= 30000000)) |> Enum.min()) - free_space
  end
end

file = File.stream!("day7.input", encoding: :utf8) |> Stream.map(&String.trim/1) |> Enum.to_list()
fs_tree = Day7.build_fs_map(file)

Day7.part1(fs_tree) |> IO.puts()
Day7.part2(fs_tree) |> IO.puts()

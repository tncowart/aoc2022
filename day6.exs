defmodule Day6 do
  @input File.open!("day6.input", encoding: :utf8) |> IO.read(:eof) |> String.to_charlist()

  def find_marker(size) do
    @input
    |> Stream.chunk_every(size, 1)
    |> Stream.map(&MapSet.new/1)
    |> Stream.with_index(size)
    |> Stream.drop_while(fn {x, _} -> size != MapSet.size(x) end)
    |> Enum.to_list()
    |> List.first()
    |> elem(1)
  end
end

Day6.find_marker(4) |> IO.puts()
Day6.find_marker(14) |> IO.puts()

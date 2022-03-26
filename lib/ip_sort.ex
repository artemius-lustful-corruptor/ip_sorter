defmodule IpSort do
  @moduledoc """
  Documentation for `IpSort`.
  """

  # @doc """
  # 1. Read list from file
  # 2. 

  # """
  # def read(path) when is_binary(path) do
  #   File.dir?(path)
  #   |> read()
  # endb

  # defp read(true), do: read_dir()

  def sort(input) do
    input
    |> read()
    |> sort_stream()
    |> write()
  end

  defp sort_stream(stream) do
    Enum.sort(stream, &comparator/2)
  end

  defp comparator(a, b) do
    dot = "."
    octetsA = String.split(a, dot)
    octetsB = String.split(b, dot)
    sort(octetsA, octetsB)

    # cond do
    #   octetsA == octetsB ->
    #     false
    #   at(octetsA, 0) > at(octetsB, 0) ->
    #     true
    #   at(octetsA, 0) < at(octetsB, 0) ->
    #     false
    #   at(octetsA, 1) > at(octetsB, 1) ->
    #     true
    #   at(octetsA, 1) < at(octetsB, 1) ->
    #     false
    #   at(octetsA, 2) > at(octetsB, 2) ->
    #     true
    #   at(octetsA, 2) < at(octetsB, 2) ->
    #     false        
    #   at(octetsA, 3) > at(octetsB, 3) ->
    #     true
    #   at(octetsA, 3) < at(octetsB, 3) ->
    #     false     
    # end
  end

  defp sort(octetsA, octetsB) when octetsA == octetsB, do: false

  defp sort(octetsA, octetsB) do
    sort(octetsA, octetsB, 0)
  end

  defp sort(octetsA, octetsB, index) when index < 3 do
    a = at(octetsA, index) |> String.to_integer()
    b = at(octetsB, index) |> String.to_integer()
    sort(octetsA, octetsB, index, compare(a, b)) |> IO.inspect()
  end

  defp sort(_, _, _), do: false

  defp sort(_, _, _, :left), do: true
  defp sort(_, _, _, :right), do: false

  defp sort(octetsA, octetsB, index, :ignore) do
    sort(octetsA, octetsB, index + 1)
  end

  defp at(enum, index), do: Enum.at(enum, index)

  defp compare(a, b) when a > b do
    IO.inspect("#{a}, #{b}")
    :left
  end

  defp compare(a, b) when a == b do
    IO.inspect("#{a}, #{b}")
    :ignore
  end

  defp compare(a, b) when a < b do
    IO.inspect("#{a}, #{b}")
    :right
  end

  # @spec read(String.t()) :: any()
  defp read(filename) do
    File.stream!(filename)
    |> Enum.map(&String.trim/1)
  end

  defp write(content) do
    formatted = Enum.join(content, "\n")
    File.write("sorted.txt", formatted)
  end
end

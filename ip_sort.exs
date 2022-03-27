defmodule IpSort do
  @moduledoc """
  `IpSort` is the script for sorting IP list.
  """

  # ----------------------------------------------------------------------------
  # API
  # ----------------------------------------------------------------------------

  @doc """
  Function to sort IP list from input file to
  output file
  """
  @spec get_sorting(String.t(), String.t()) :: any()
  def get_sorting(input, output) do
    input
    |> read()
    |> Enum.sort(&comparator/2)
    |> write(output)
  end

  # ----------------------------------------------------------------------------
  # HELPERS
  # ----------------------------------------------------------------------------

  defp comparator(a, b) do
    dot = "."
    octetsA = String.split(a, dot)
    octetsB = String.split(b, dot)
    sort(octetsA, octetsB)
  end

  defp sort(octetsA, octetsB) when octetsA == octetsB, do: false

  defp sort(octetsA, octetsB) do
    sort(octetsA, octetsB, 0)
  end

  defp sort(octetsA, octetsB, index) when index < 3 do
    a = at(octetsA, index) |> String.to_integer()
    b = at(octetsB, index) |> String.to_integer()
    sort(octetsA, octetsB, index, compare(a, b))
  end

  defp sort(_, _, _), do: false

  defp sort(_, _, _, :left), do: true
  defp sort(_, _, _, :right), do: false

  defp sort(octetsA, octetsB, index, :ignore) do
    sort(octetsA, octetsB, index + 1)
  end

  defp at(enum, index), do: Enum.at(enum, index)

  defp compare(a, b) when a > b do
    :left
  end

  defp compare(a, b) when a == b do
    :ignore
  end

  defp compare(a, b) when a < b do
    :right
  end

  defp read(filename) do
    File.stream!(filename)
    |> Enum.map(&String.trim/1)
  end

  defp write(content, output) do
    formatted = Enum.join(content, "\n")
    File.write(output, formatted)
  end
end

# RUN script

[input, output] = System.argv()
IpSort.get_sorting(input, output)

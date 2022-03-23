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
  # end

  #defp read(true), do: read_dir()

  

  def sort(input) do
    input
    |> read()
    |> sort_stream()
    |> write()
  end

  defp sort_stream(stream) do
    Enum.sort(stream, &comparator/2)
  end

  defp comparator(a,b) do
    dot = "."
    octetsA = String.split(a, dot)
    octetsB = String.split(b, dot)
  end
  
  #@spec read(String.t()) :: any()
  defp read(filename) do
    File.stream!(filename)
    |> Enum.map(&String.trim/1)
    #|> Enum.join("\n")
  end

  defp write(content) do
    File.write("sorted.txt", content)
  end

  def read_dir(path) do
  end

  
end

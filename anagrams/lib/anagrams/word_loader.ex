defmodule Anagrams.WordLoader do

  def from_files(filenames) do
    filenames
    |> Stream.map(&load_task(&1))
    |> Enum.map(&Task.await/1)
  end

  defp load_task(filename) do
    Task.async(fn ->
      File.stream!(filename, [], :line)
      |> Enum.map(&String.strip/1)
      |> Anagrams.Dictionary.add_words
    end)
  end
end
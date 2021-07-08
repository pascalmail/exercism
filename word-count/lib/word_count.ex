defmodule WordCount do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    sentence
      |> String.downcase()
      |> String.replace(~r/[!&@$%\^&,:_]/, " ")
      |> String.split()
      |> Enum.reduce(%{}, fn x, acc -> Map.update(acc, x, 1, fn y -> y + 1 end) end)
  end
end

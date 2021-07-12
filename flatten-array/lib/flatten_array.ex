defmodule FlattenArray do
  @doc """
    Accept a list and return the list flattened without nil values.

    ## Examples

      iex> FlattenArray.flatten([1, [2], 3, nil])
      [1,2,3]

      iex> FlattenArray.flatten([nil, nil])
      []

  """

  @spec flatten(list) :: list
  def flatten(list) do
    flat(list, [])
  end

  defp flat(list, acc) do
    case list do
      [] -> acc
      [head | tail] -> flat(head, flat(tail, acc))
      nil -> acc
      x -> [x| acc]
    end
  end
end

defmodule Change do
  @doc """
    Determine the least number of coins to be given to the user such
    that the sum of the coins' value would equal the correct amount of change.
    It returns {:error, "cannot change"} if it is not possible to compute the
    right amount of coins. Otherwise returns the tuple {:ok, list_of_coins}

    ## Examples

      iex> Change.generate([5, 10, 15], 3)
      {:error, "cannot change"}

      iex> Change.generate([1, 5, 10], 18)
      {:ok, [1, 1, 1, 5, 10]}

  """

  @spec generate(list, integer) :: {:ok, list} | {:error, String.t()}
  def generate(coins, target) do
    res = min_changes(coins, target, %{0 => []})[target]
    case res do
      nil -> {:error, "cannot change"}
      _ -> {:ok, res}
    end
  end

  def min_changes(_, 0, map), do: map
  def min_changes(_, x, map) when x < 0, do: map
  def min_changes([], _, map), do: map
  def min_changes(cs, v, map) do
    Enum.reduce(cs, map, fn c, mmap ->
      rest = v - c

      new_maps = if mmap[rest] do
        mmap
      else
        min_changes(cs, rest, mmap)
      end

      # cannot find changes of rest, just return mappings as is
      if new_maps[rest] == nil do
        new_maps
      else
        # we have the changes of rest
        # update the changes of v based on changes of rest
        new_coins = [c | new_maps[rest]]
        if new_maps[v] do
          if length(new_coins) < length(new_maps[v]) do
            Map.put(new_maps, v, new_coins)
          else
            new_maps
          end
        else
          # new_maps have no value yet, create it
          Map.put(new_maps, v, new_coins)
        end
      end

    end)
  end
end

defmodule ListOps do
  # Please don't use any external modules (especially List or Enum) in your
  # implementation. The point of this exercise is to create these basic
  # functions yourself. You may use basic Kernel functions (like `Kernel.+/2`
  # for adding numbers), but please do not use Kernel functions for Lists like
  # `++`, `--`, `hd`, `tl`, `in`, and `length`.

  @spec count(list) :: non_neg_integer
  def count(l) do
    case l do
      [] -> 0
      [_ | tail] -> 1 + count(tail)
    end
  end

  @spec reverse(list) :: list
  def reverse(l) do
    rev(l, [])
  end

  defp rev([], acc), do: acc
  defp rev([h|t], acc), do: rev(t, [h|acc])

  @spec map(list, (any -> any)) :: list
  def map(l, f) do
    case l do
      [] -> []
      [h | t] -> [f.(h) | map(t, f)]
    end
  end

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(l, f) do
    case l do
      [] -> []
      [h | t] ->
        case f.(h) do
          true -> [h | filter(t, f)]
          false -> filter(t, f)
        end
    end
  end

  @type acc :: any
  @spec reduce(list, acc, (any, acc -> acc)) :: acc
  def reduce(l, acc, f) do
    case l do
      [] -> acc
      [h | t] -> reduce(t, f.(h, acc), f)
    end
  end

  @spec append(list, list) :: list
  def append(a, b) do
    case a do
      [] -> b
      [h| t] -> [h | append(t, b)]
    end
  end


  @spec concat([[any]]) :: [any]
  def concat(ll) do
    case ll do
      [] -> []
      [h | t] -> append(h, concat(t))
    end
  end
end

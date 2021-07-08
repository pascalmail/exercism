use Bitwise
defmodule SecretHandshake do
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    ops = [code &&& 1, code &&& 2, code &&& 4, code &&& 8, code &&& 16]

    Enum.reduce(ops, [], fn op, acc ->
      case op do
        1 -> acc ++ ["wink"]
        2 -> acc ++ ["double blink"]
        4 -> acc ++ ["close your eyes"]
        8 -> acc ++ ["jump"]
        16 -> Enum.reverse(acc)
        _ -> acc
      end
    end)
  end
end

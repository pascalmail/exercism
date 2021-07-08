defmodule RomanNumerals do
  @doc """
  Convert the number to a roman number.
  """
  @spec numeral(pos_integer) :: String.t()
  def numeral(number) do
    a = rom(rem(number, 10), "I", "V", "X")
    b = rom(rem(div(number,10), 10), "X", "L", "C")
    c = rom(rem(div(number,100), 10), "C", "D", "M")
    d = rom(rem(div(number,1000), 10), "M", "", "")

    "#{d}#{c}#{b}#{a}"
  end

  def rom(num, one, five, ten) do
    case num do
      1 -> "#{one}"
      2 -> "#{one}#{one}"
      3 -> "#{one}#{one}#{one}"
      4 -> "#{one}#{five}"
      5 -> "#{five}"
      6 -> "#{five}#{one}"
      7 -> "#{five}#{one}#{one}"
      8 -> "#{five}#{one}#{one}#{one}"
      9 -> "#{one}#{ten}"
      _ -> ""
    end
  end
end

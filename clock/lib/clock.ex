defmodule Clock do
  defstruct hour: 0, minute: 0

  @doc """
  Returns a clock that can be represented as a string:

      iex> Clock.new(8, 9) |> to_string
      "08:09"
  """
  @spec new(integer, integer) :: Clock
  def new(hour, minute) do
    {h, m} = normal_clock(hour, minute)
    %Clock{hour: h, minute: m}
  end

  @doc """
  Adds two clock times:

      iex> Clock.new(10, 0) |> Clock.add(3) |> to_string
      "10:03"
  """
  @spec add(Clock, integer) :: Clock
  def add(%Clock{hour: hour, minute: minute}, add_minute) do
    {h, m} = normal_clock(hour, minute + add_minute)
    %Clock{hour: h, minute: m}
  end

  defimpl String.Chars, for: Clock do
    def to_string(clock) do
      hstr = clock.hour |> Integer.to_string() |> String.pad_leading(2, "0")
      mstr = clock.minute |> Integer.to_string() |> String.pad_leading(2, "0")
      "#{hstr}:#{mstr}"
    end
  end

  defp normal_clock(hour, minute) do
    day_minutes = 24 * 60
    tm = rem(hour * 60 + minute, day_minutes)
    # make it positive
    tm = rem(tm + day_minutes, day_minutes)


    {div(tm, 60), rem(tm, 60)}
  end
end

defmodule Gigasecond do
  @doc """
  Calculate a date one billion seconds after an input date.
  """
  @spec from({{pos_integer, pos_integer, pos_integer}, {pos_integer, pos_integer, pos_integer}}) ::
          :calendar.datetime()

  def from({{year, month, day}, {hours, minutes, seconds}}) do
    {:ok, d} = Date.new(year, month, day)
    {:ok, t} = Time.new(hours, minutes, seconds)
    {:ok, dt} = DateTime.new(d, t)
    nt = DateTime.add(dt, 1000000000, :second)
    {{nt.year, nt.month, nt.day}, {nt.hour, nt.minute, nt.second}}
  end
end

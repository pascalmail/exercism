defmodule RobotSimulator do
  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec create(direction :: atom, position :: {integer, integer}) :: any
  def create(direction \\ :north, position \\ {0,0}) do
    directions = [:north, :south, :west, :east]
    cond do
      !Enum.find(directions, false, &(&1 == direction)) -> {:error, "invalid direction"}
      !is_tuple(position) -> {:error, "invalid position"}
      tuple_size(position) != 2 -> {:error, "invalid position"}
      tuple_size(position) == 2 && !is_number(elem(position, 0)) -> {:error, "invalid position"}
      tuple_size(position) == 2 && !is_number(elem(position, 1)) -> {:error, "invalid position"}
      true -> %{pos: position, dir: direction}
    end


  end

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: any, instructions :: String.t()) :: any
  def simulate(robot, instructions) do
    String.codepoints(instructions) |> Enum.reduce_while(robot, fn i, r ->
      rb = case i do
        "R" ->
          case r[:dir] do
            :north -> %{pos: r[:pos], dir: :east}
            :east -> %{pos: r[:pos], dir: :south}
            :south -> %{pos: r[:pos], dir: :west}
            :west -> %{pos: r[:pos], dir: :north}
          end
        "L" ->
          case r[:dir] do
            :north -> %{pos: r[:pos], dir: :west}
            :east -> %{pos: r[:pos], dir: :north}
            :south -> %{pos: r[:pos], dir: :east}
            :west -> %{pos: r[:pos], dir: :south}
          end
        "A" ->
          x = elem(r[:pos], 0)
          y = elem(r[:pos], 1)
          case r[:dir] do
            :north -> %{pos: {x, y+1}, dir: r[:dir]}
            :east -> %{pos: {x+1, y}, dir: r[:dir]}
            :south -> %{pos: {x, y-1}, dir: r[:dir]}
            :west -> %{pos: {x-1, y}, dir: r[:dir]}
          end
        _ ->
          {:error, "invalid instruction"}
      end
      cond do
        rb == {:error, "invalid instruction"} -> {:halt, rb}
        true -> {:cont, rb}
      end
    end)


  end

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot :: any) :: atom
  def direction(robot) do
    robot[:dir]
  end

  @doc """
  Return the robot's position.
  """
  @spec position(robot :: any) :: {integer, integer}
  def position(robot) do
    robot[:pos]
  end
end

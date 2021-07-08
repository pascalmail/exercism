defmodule Bob do
  def hey(input) do
    token = String.trim(input)
    cond do
      # not saying anything
      token == "" -> "Fine. Be that way!"

      # SHOUTING QUESTION?
      String.last(token) == "?"&& String.match?(token, ~r/[[:upper:]]/) && String.upcase(token) == token -> "Calm down, I know what I'm doing!"

      # question?
      String.last(token) == "?" && String.match?(token, ~r/^.*\?$/) -> "Sure."

      # YELL
      String.match?(token, ~r/[[:upper:]]/) && String.upcase(token) == token -> "Whoa, chill out!"

      # others
      true -> "Whatever."
    end
  end
end

defmodule Markdown do
  @doc """
    Parses a given string with Markdown syntax and returns the associated HTML for that string.

    ## Examples

    iex> Markdown.parse("This is a paragraph")
    "<p>This is a paragraph</p>"

    iex> Markdown.parse("#Header!\n* __Bold Item__\n* _Italic Item_")
    "<h1>Header!</h1><ul><li><em>Bold Item</em></li><li><i>Italic Item</i></li></ul>"
  """
  @spec parse(String.t()) :: String.t()
  def parse(markdown) do
    # Convert m to array of line
    # process each line
    # rejoin the line
    # patch the processed line
    String.split(markdown, "\n")
      |> Enum.map(&process/1)
      |> Enum.join()
      |> patch()
  end

  defp process(t) do
    cond do
      String.starts_with?(t, "#") -> parse_header_md_level(t)
      String.starts_with?(t, "*") -> parse_list_md_level(t)
      true -> enclose_with_paragraph_tag(String.split(t))
    end
  end

  defp parse_header_md_level(hwt) do
    [h | t] = String.split(hwt)

    hl = String.length(h)
    htl = Enum.join(t, " ")

    "<h#{hl}>#{htl}</h#{hl}>"
  end

  defp parse_list_md_level(line) do
    t = line
      |> String.trim_leading("* ")
      |> String.split()
    "<li>" <> join_words_with_tags(t) <> "</li>"
  end

  defp enclose_with_paragraph_tag(words) do
    "<p>#{join_words_with_tags(words)}</p>"
  end

  defp join_words_with_tags(words) do
    words
      |> Enum.map(fn word -> replace_md_with_tag(word) end)
      |> Enum.join(" ")
  end

  defp replace_md_with_tag(word) do
    word
      |> replace_prefix_md()
      |> replace_suffix_md()
  end


  defp replace_prefix_md(word) do
    cond do
      word =~ ~r/^#{"__"}{1}/ -> String.replace(word, ~r/^#{"__"}{1}/, "<strong>", global: false)
      word =~ ~r/^[#{"_"}{1}][^#{"_"}+]/ -> String.replace(word, ~r/_/, "<em>", global: false)
      true -> word
    end
  end

  defp replace_suffix_md(word) do
    cond do
      word =~ ~r/#{"__"}{1}$/ -> String.replace(word, ~r/#{"__"}{1}$/, "</strong>")
      word =~ ~r/[^#{"_"}{1}]/ -> String.replace(word, ~r/_/, "</em>")
      true -> word
    end
  end

  defp patch(line) do
    line
      |> String.replace("<li>", "<ul>" <> "<li>", global: false)
      |> String.replace_suffix("</li>", "</li>" <> "</ul>")
  end
end

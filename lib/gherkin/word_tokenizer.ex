defmodule Gherkin.WordTokinizer do

  @moduledoc """
    Converts parsed inputs in to tokens
  """

  defmodule Token, do: defstruct word: "", start_of_line: false

  def run(input) do
    Enum.map(
      Gherkin.Parser.run(input), 
      fn(current_line) -> line(current_line) end
    ) 
  end

  def line(parsed_words) do
    [first_word | rest] = Enum.map(
      parsed_words, 
      fn(word_text) ->  %WordToken{ word: word_text } end
    )
    
    # Not sure if I should be redefining like this.
    [ %Token{ word: first_word.word, start_of_line: true } | rest ]
  end

end

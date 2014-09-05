defmodule Gherkin.SyntaxTokinizer do

  defmodule Feature, do: defstruct word_tokens: []
  defmodule Scenario, do: defstruct word_tokens: []
  defmodule Given, do: defstruct word_tokens: []
  defmodule When, do: defstruct word_tokens: []
  defmodule Then, do: defstruct word_tokens: []
  
  def run(input) do
    Enum.map(
      Gherkin.WordTokinizer.run(input),
      fn(current_line) -> tokenize(current_line) end
    ) 
  end

  defp tokenize([ %WordToken{word: "Feature"} | rest ]) do
    %Feature{ word_tokens: rest }
  end

  defp tokenize([ %WordToken{ word: "Scenario" } | rest ]) do
    %Scenario{ word_tokens: rest }
  end

  defp tokenize([ %WordToken{ word: "Given" } | rest ]) do
    %Given{ word_tokens: rest }
  end

  defp tokenize([ %WordToken{ word: "When" } | rest ]) do
    %When{ word_tokens: rest }
  end

  defp tokenize([ %WordToken{ word: "Then" } | rest ]) do
    %Then{ word_tokens: rest }
  end
end

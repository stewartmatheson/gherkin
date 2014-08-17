defmodule Gherkin.Line do

  @moduledoc """
    Return's domain objects based on parsed lines of text
  """

  defmodule Feature, do: defstruct line: "", name: ""
  defmodule Scenario, do: defstruct line: "", name: ""
  defmodule Step, do: defstruct line: "", step: "", type: ""
  defmodule Blank, do: defstruct line: ""
  defmodule Text, do: defstruct line: ""

  def type_of("") do
    %Blank{line: "" }
  end

  def type_of(line) do
    cond do
      line =~ ~r/^Feature(:| ){1,3}/ ->
        [ name | _ ] = String.split(line, ~r/^Feature(:| ){1,3}/, trim: true)
        %Feature{line: line, name: name}

      line =~ ~r/^Scenario(:| ){1,3}/ ->
        [ name | _ ] = String.split(line, ~r/^Scenario(:| ){1,3}/ , trim: true)
        %Scenario{line: line, name: name}

      line =~ ~r/^(Given|When|Then|And) / ->
        [ action | rest ] = String.split(line, " ")
        %Step{line: line, step: Enum.join(rest, " "), type: String.to_atom(action) }

      true ->
        %Text{line: line}
    end
  end
end

defmodule Gherkin.Line do

  @moduledoc """
    Return's domain objects based on parsed lines of text
  """

  defmodule Feature, do: defstruct line: "", name: ""
  defmodule Scenario, do: defstruct line: "", name: ""
  defmodule Step, do: defstruct line: "", step: "", type: ""
  defmodule Blank, do: defstruct line: ""

  def type_of("") do
    %Blank{line: "" }
  end

  def type_of(line) do
    cond do
      line =~ ~r/^Feature: / ->
        [ name | _ ] = String.split(line, ~r{^Feature: }, trim: true)
        %Feature{line: line, name: name}

      line =~ ~r/^Scenario: / ->
        [ name | _ ] = String.split(line, ~r{^Scenario: }, trim: true)
        %Scenario{line: line, name: name}

      line =~ ~r/^(Given|When|Then|And) / ->
        [ action | step ] = String.split(line, ~r{^(Given|When|And|Then) }, trim: true)
        %Step{line: line, step: List.first(step), type: String.to_atom(action) }
    end
  end
end

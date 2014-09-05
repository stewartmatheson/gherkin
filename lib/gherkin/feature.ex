require IEx

defmodule Gherkin.Feature do

  @moduledoc """
    Converts a set of parsed feature lines in to a feature with assiocated scenarios
  """

  alias Gherkin.Ast
  alias Gherkin.Line

  def parse([]) do
    []
  end

  def parse(lines) do
    parsed_lines = Enum.map(lines, fn(line) -> Line.type_of(line) end)
    parse parsed_lines, []
  end

  defp parse([feature_line = %Line.Feature{} | rest], []) do
    parse rest, [ feature_line ]
  end

  defp parse([text_line = %Line.Text{} | rest], lines) do
    parse rest, lines ++ [ text_line ]
  end

  defp parse([ %Line.Blank{} | rest], lines) do
    parse rest, lines
  end

  defp parse([scenario_line = %Line.Scenario{} | rest], lines) do
    scenarios = Gherkin.Scenario.parse([ scenario_line | rest ])
    [ feature_line | _ ] = lines
    %Ast.Feature{name: feature_line.name, scenarios: scenarios, feature_description: lines}
  end

  defp parse([], lines) do
    [feature_line | _ ] = lines
    %Ast.Feature{name: feature_line.name, scenarios: [], feature_description: lines}
  end

end

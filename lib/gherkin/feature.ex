defmodule Gherkin.Feature do

  @moduledoc """
    Converts a set of parsed feature lines in to a feature with assiocated scenarios
  """

  defstruct name: "", scenarios: []

  alias Gherkin.Line

  def parse([]) do
    []
  end

  def parse(lines) do
    parsed_lines = Enum.map(lines, fn(line) -> Line.type_of(line) end)
    parse parsed_lines, []
  end

  def parse([feature_line = Line.Feature | rest], []) do
    parse rest, [ feature_line ]
  end

  def parse([text_line = Line.Text | rest], lines) do
    parse rest, lines ++ [ text_line ]
  end

  def parse([blank_line = Line.Blank | rest], lines) do
    parse rest, lines
  end

  def parse([scenario_line = Line.Scenario | rest], lines) do
    [feature_line | rest ] = lines
    scenarios = Gherkin.Scenario.parse [scenario_line | rest ]
    %Gherkin.Feature{name: feature_line.name, scenarios: scenarios}
  end

  def parse([], lines) do
    [feature_line | rest ] = lines
    %Gherkin.Feature{name: feature_line.name, scenarios: []}
  end

end

defmodule Gherkin.Feature do

  @moduledoc """
    Converts a set of parsed lines in to a block and maps to correct macros
  """

  alias Gherkin.Line

  defstruct feature_name: "", lines: []

  def parse([]) do
    nil
  end

  def parse(lines) do
    lines
      |> Enum.map(fn(line) -> Line.type_of(line) end)

    parse lines, [], []
  end

  def parse([feature_line = Line.Feature | rest], [], features) do
    parse rest, [ feature_line ], features
  end

  def parse([feature_line = Line.Feature | rest], lines, features) do
    parse rest, [], features ++ [ %Feature{feature_name: feature_line.name, lines: lines} ]
  end

  def parse([step_line = Line.Step | rest], lines, features) do
    parse rest, lines ++ [ step_line ], features
  end

  def parse([text_line = Line.Text | rest], lines, features) do
    parse rest, lines ++ [ step_line ], features
  end

  def parse([blank_line = Line.Blank | rest], lines, features) do
    parse rest, lines, features
  end

  def parse([], lines, features) do
    [ feature_line | _ ] = lines
    features ++ [ %Feature{feature_name: feature_line.name, lines: lines} ]
  end
end

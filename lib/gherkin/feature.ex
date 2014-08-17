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

    parse lines
  end

  defp parse([ Line.Feature | rest ]) do
    
  end

end

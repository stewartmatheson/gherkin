defmodule Gherkin.Scenario do

  @moduledoc """
    Converts a set of parsed steps in to Scenarios with steps mapped
  """

  alias Gherkin.Line

  defstruct name: "", steps: []

  def parse([]) do
    []
  end

  def parse([scenario_step = Line.Scenario | rest], [], scenarios) do
    parse rest, [ scenario_step ], scenarios
  end

  def parse([scenario_step = Line.Scenario | rest], steps, scenarios) do
    parse rest, [], scenarios ++ [ %Gherkin.Scenario{name: scenario_step.name, steps: steps} ]
  end

  def parse([step_step = Line.Step | rest], steps, scenarios) do
    parse rest, steps ++ [ step_step ], scenarios
  end

  def parse([text_step = Line.Text | rest], steps, scenarios) do
    parse(rest, steps ++ [ text_step ], scenarios)
  end

  def parse([blank_step = Line.Blank | rest], steps, scenarios) do
    parse rest, steps, scenarios
  end

  def parse([], steps, scenarios) do
    [ scenario_step | _ ] = steps
    scenarios ++ [ %Gherkin.Scenario{name: scenario_step.name, steps: steps} ]
  end
end

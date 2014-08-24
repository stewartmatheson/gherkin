defmodule Gherkin.Ast do

  @moduledoc """
    Contains strucutres representing the abstract syntax tree of Gherkin. These
    are created as text lines form cucubmer features are parsed
  """

  defmodule Feature, do: defstruct name: "", scenarios: [], feature_description: []
  defmodule Scenario, do: defstruct name: "", steps: []
end

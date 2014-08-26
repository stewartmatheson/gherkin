defmodule FeatureTest do
  use ExUnit.Case

  test "Features get parsed correctly" do
    feature = [
      "Feature : Something",
      "As a user",
      "I should be able to do some other stuff",
      "Scenario : Users want to be able to do something",
      "When I do something",
      "Given something has happend",
      "Then something should have happened"
    ]

    assert %Gherkin.Ast.Feature{ name: "Something"} == Gherkin.Feature.parse(feature)
  end
end

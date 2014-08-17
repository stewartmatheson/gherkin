defmodule FeatureTest do
  use ExUnit.Case

  feature = [
    "Scenario : Something",
    "As a user",
    "When I  do something",
    "Something should happen",
    "Given",
    "When",
    "Then"
  ]

  parsed_feature = Gherkin.Feature.parse(feature)
  assert %Gherkin.Feature{ feature_name: "Something"} == parsed_feature
end

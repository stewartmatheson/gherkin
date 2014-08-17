defmodule LineTest do
  use ExUnit.Case

  alias Gherkin.Line

  [
    { "Feature: Some awesome feature", %Line.Feature{name: "Some awesome feature"} },
    { "Scenario: I interact with test", %Line.Scenario{name: "I interact with test"} },
    { "And I do something", %Line.Step{step: "I do something", type: :And} },
    { "When I interact with test", %Line.Step{step: "I interact with test", type: :When} },
    { "Then I assert something", %Line.Step{step: "I assert something", type: :Then} },
    { "Given I assert something", %Line.Step{step: "I assert something", type: :Given} },
    { "As a user", %Line.Text{line: "As a user"} },
    { "", %Line.Blank{} }
  ]
  |> Enum.each(fn { text, type } -> 
       test("line: '" <> text <> "'") do
         struct = unquote(Macro.escape type)
         struct = %{ struct | line: unquote(text) }
         assert Line.type_of(unquote(text)) == struct
       end
     end)
end

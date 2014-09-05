defmodule Gherkin.Parser do

  def run(input) do
    parse_features(Gherkin.SyntaxTokinizer.run(input))
  end

  defp parse_features([ feature = %Gherkin.SyntaxTokinizer.Feature{} | rest ]) do 
    %Gherkin.Ast.Feature{ name: feature.name, scenarios: parse_scenarios(rest) }
  end

  defp parse_feature(feature, [ scenario = %Gherkin.SyntaxTokinizer.Scenario{} | rest ]) do
    parse_scenario(scenario, rest)  
  end

  defp parse_scenario(scenario = %Gherkin.SyntaxTokinizer.Scenario{}, 
                      [ given = %Gherkin.SyntaxTokinizer.Given{} | rest ]) do

    ast_given = %Gherkin.Ast.Given{   }
    parse_scenario(%Gherkin.Ast.Scenario{ name: scenario.text, steps: [ ast_given ]  })
  end


end

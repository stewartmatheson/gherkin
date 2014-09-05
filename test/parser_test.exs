defmodule ParserTest do
  use ExUnit.Case
  
  def test_parse do
    file_content = elem(File.read('test/fixtures/test.feature'), 1)
    assert Gherkin.Parser.parse(file_content)
  end
end

defmodule ChemistTest do
  use ExUnit.Case
  doctest Chemist

  test "the truth" do
    assert 1 + 1 == 2
  end
  
  test "not the truth" do
    assert 1 + 1 == 5
  end
end

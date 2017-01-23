defmodule ChampionMasteryTest do
  use ExUnit.Case
  doctest Chemist

  import Chemist.ChampionMastery
    
  test "return mastery data for champion" do
    region = "na"
    player_id = 51666047
    champion_id = 126
    
    {status, data} = champion(region, player_id, champion_id)
    assert status == :ok
    assert Map.fetch(data, "championId") == { :ok, champion_id }
  end

  test "return mastery data for all champions, ensure map w/ 'championId => 126' in returned data" do
    region = "na"
    player_id = 51666047
    champion_id = 126
    
    {status, data} = champions(region, player_id)
    assert status == :ok
    assert Enum.any?(data, &( Map.fetch(&1, "championId") == { :ok, champion_id } )) == true
  end

  test "return score as an integer" do
    region = "na"
    player_id = 51666047
    
    {status, data} = score(region, player_id)
    assert status == :ok
    assert is_integer(data)
  end
  
  test "return list of top 3 champions" do
    region = "na"
    player_id = 51666047
    
    {status, data} = top_champions(region, player_id)
    assert status == :ok
    assert is_list(data)
    assert Enum.count(data) == 3
  end
end

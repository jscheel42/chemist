defmodule ChampionMasteryTest do
  use ExUnit.Case
  doctest Chemist

  import Chemist.ChampionMastery
  
  @api_key      Application.get_env(:chemist, :api_key)
  
  test "return url for a single champion mastery" do
    assert url("na", "NA1", 22415415, "champion", 126) ==
      "https://na.api.pvp.net/championmastery/location/NA1/player/22415415/champion/126?api_key=#{@api_key}"
  end
  
  test "return url for mastery categories: champions, score, topchampions" do
    assert url("na", "NA1", 22415415, "champions") ==
      "https://na.api.pvp.net/championmastery/location/NA1/player/22415415/champions?api_key=#{@api_key}"
    assert url("na", "NA1", 22415415, "score") ==
      "https://na.api.pvp.net/championmastery/location/NA1/player/22415415/score?api_key=#{@api_key}"
    assert url("na", "NA1", 22415415, "topchampions") ==
      "https://na.api.pvp.net/championmastery/location/NA1/player/22415415/topchampions?api_key=#{@api_key}"
  end

  test "return mastery data for champion" do
    region = "na"
    platform_id = "NA1"
    player_id = 22415415
    champion_id = 126
    
    {status, data} = fetch_champion(region, platform_id, player_id, champion_id)
    assert status == :ok
    assert Map.fetch(data, "championId") == { :ok, champion_id }
  end

  test "return mastery data for all champions, ensure map w/ 'championId => 126' in returned data" do
    region = "na"
    platform_id = "NA1"
    player_id = 22415415
    champion_id = 126
    
    {status, data} = fetch_champions(region, platform_id, player_id)
    assert status == :ok
    assert Enum.any?(data, &( Map.fetch(&1, "championId") == { :ok, champion_id } )) == true
  end

  test "return score as an integer" do
    region = "na"
    platform_id = "NA1"
    player_id = 22415415
    
    {status, data} = fetch_score(region, platform_id, player_id)
    assert status == :ok
    assert is_integer(data)
  end
  
  test "return list of top 3 champions" do
    region = "na"
    platform_id = "NA1"
    player_id = 22415415
    
    {status, data} = fetch_top_champions(region, platform_id, player_id)
    assert status == :ok
    assert is_list(data)
    assert Enum.count(data) == 3
  end
end

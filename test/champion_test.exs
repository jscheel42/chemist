defmodule ChampionTest do
  use ExUnit.Case
  doctest Chemist

  import Chemist.Champion
  
  @api_key      Application.get_env(:chemist, :api_key)
  @api_version  Application.get_env(:chemist, :api_version_champion)
  
  test "return champion url for all champion in region" do
    assert url("na") ==
      "https://na.api.pvp.net/api/lol/na/v#{@api_version}/champion?api_key=#{@api_key}"
  end
  
  test "return champion url for single champion id" do
    assert url("euw", 126) ==
      "https://euw.api.pvp.net/api/lol/euw/v#{@api_version}/champion/126?api_key=#{@api_key}"    
  end

  test "return data for champion with id 126" do
    champion_id = 126
    region = "na"
    
    {status, data} = fetch(region, champion_id)
    assert status == :ok
    assert Map.fetch(data, "id") == { :ok, champion_id }
  end

  test "return data for all champions, ensure map w/ 'id => 126' in returned data" do
    champion_id = 126
    region = "na"
    
    {status, data} = fetch_all(region)
    assert status == :ok
        
    assert true == Enum.any?(data, &( Map.fetch(&1, "id") == { :ok, champion_id } ))
  end
end

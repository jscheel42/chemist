defmodule ChampionTest do
  use ExUnit.Case
  doctest Chemist

  import Chemist.Champion
  
  @api_key      Application.get_env(:chemist, :api_key)
  @api_version  Application.get_env(:chemist, :api_version_champion)
  
  test "return data for champion with id 126" do
    champion_id = 126
    region = "euw"
    
    {status, data} = champion(region, champion_id)
    assert status == :ok
    assert Map.fetch(data, "id") == { :ok, champion_id }
  end

  test "return data for all champions, ensure map w/ 'id => 126' in returned data" do
    champion_id = 126
    region = "euw"
    
    {status, data} = champions(region)
    assert status == :ok
        
    assert Enum.any?(data, &( Map.fetch(&1, "id") == { :ok, champion_id } ))
  end
end

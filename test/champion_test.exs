defmodule ChampionTest do
  use ExUnit.Case
  doctest Chemist

  import Chemist.Champion
  import Chemist.Util
    
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
    
    data_striped_key = strip_key!(data)
        
    assert Enum.any?(data_striped_key, &( Map.fetch(&1, "id") == { :ok, champion_id } ))
  end
end

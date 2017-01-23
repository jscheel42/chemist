defmodule SummonerTest do
  use ExUnit.Case
  doctest Chemist

  import Chemist.Summoner
  import Chemist.Util
    
  test "return summoner json, supply summoner name" do
    summoner_name = "jrizznezz"
    region = "na"
    
    {status, data} = summoner_by_name(region, summoner_name)
    assert status == :ok
    
    data_striped_key = strip_key!(data)
    
    assert Map.fetch(data_striped_key, "name") == { :ok, summoner_name }
  end
end

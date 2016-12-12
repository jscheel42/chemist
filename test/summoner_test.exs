defmodule SummonerTest do
  use ExUnit.Case
  doctest Chemist

  import Chemist.Summoner
  import Chemist.Util
  
  @api_key      Application.get_env(:chemist, :api_key)
  @api_version  Application.get_env(:chemist, :api_version_summoner)
  
  test "return summoner json, supply summoner name" do
    summoner_name = "jrizznezz"
    region = "na"
    
    {status, data} = summoner_by_name(region, summoner_name)
    assert status == :ok
    
    data_striped_key = strip_key!(data)
    
    assert Map.fetch(data_striped_key, "name") == { :ok, summoner_name }
  end
end

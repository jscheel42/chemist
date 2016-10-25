defmodule SummonerTest do
  use ExUnit.Case
  doctest Chemist

  import Chemist.Summoner
  
  @api_key      Application.get_env(:chemist, :api_key)
  @api_version  Application.get_env(:chemist, :api_version_summoner)
  
  test "return summoner json, supply summoner name" do
    summoner_name = "Sandvich Von Nom"
    region = "na"
    
    {status, data} = summoner(region, summoner_name)
    assert status == :ok
    assert Map.fetch(data, "name") == { :ok, summoner_name }
  end
end

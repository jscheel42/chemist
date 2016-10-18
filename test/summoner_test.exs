defmodule SummonerTest do
  use ExUnit.Case
  doctest Chemist

  import Chemist.Summoner
  
  @api_key      Application.get_env(:chemist, :api_key)
  @api_version  Application.get_env(:chemist, :api_version_summoner)

  test "return shortname, supply name with spaces" do
    assert remove_spaces("singed player 42") == "singedplayer42"
  end
  
  test "return summoner url, supply shortname & region" do
    assert url("sandvichvonnom", "na") ==
      "https://na.api.pvp.net/api/lol/na/v#{@api_version}/summoner/by-name/sandvichvonnom?api_key=#{@api_key}"
    assert url("sandvichvonnom", "euw") ==
      "https://euw.api.pvp.net/api/lol/euw/v#{@api_version}/summoner/by-name/sandvichvonnom?api_key=#{@api_key}"
  end
  
  test "return summoner json, supply summoner name" do
    summoner_name = "Sandvich Von Nom"
    region = "na"
    
    {status, shortname, data} = fetch(summoner_name, region)
    assert status == :ok
    assert shortname == "sandvichvonnom"
    assert Map.fetch(data, "name") == { :ok, summoner_name }
  end
end

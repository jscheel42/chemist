defmodule MatchTest do
  use ExUnit.Case
  doctest Chemist

  import Chemist.Match
    
  test "return match by match id" do
    region = "na"
    match_id = 2054994244
    
    { :ok, match } = match_by_id(region, match_id)
    
    assert Map.has_key?(match, "mapId")    
  end
  
  test "return matchlist by summoner id" do
    region = "na"
    summoner_id = 51666047
    
    { :ok, matchlist } = matchlist_by_id(region, summoner_id)
    
    assert Map.has_key?(matchlist, "matches")
  end
end

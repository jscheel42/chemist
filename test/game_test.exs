defmodule GameTest do
  use ExUnit.Case
  doctest Chemist

  import Chemist.Game
  import Chemist.Util
    
  test "Return featured games" do
    region = "lan"
    
    { :ok, featured_games } = featured(region)

    assert Map.has_key?(featured_games, "gameList")

    first_featured = 
      Map.fetch!(featured_games, "gameList")
      |> List.first
      
    assert Map.has_key?(first_featured, "participants")
    
    first_participant =
      Map.fetch!(first_featured, "participants")
      |> List.first
      
    assert Map.has_key?(first_participant, "summonerName")
  end
  
  test "Return recent games" do
    player_id = "51666047"
    region = "na"
    
    { :ok, recent_games } = recent(region, player_id)
        
    first_recent = 
      recent_games
      |> strip_key!
      |> List.first
    
    assert Map.has_key?(first_recent, "championId")
  end
end

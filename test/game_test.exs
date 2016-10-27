defmodule GameTest do
  use ExUnit.Case
  doctest Chemist

  import Chemist.Game
  
  @api_key            Application.get_env(:chemist, :api_key)
  
  test "Return featured games" do
    region = "euw"
    
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
    
    first_participant_name = Map.fetch!(first_participant, "summonerName")
    
    player_id = Chemist.Summoner.summoner_id(region, first_participant_name)
    
    { :ok, current_game } = current(region, player_id)
    
    assert Map.has_key?(current_game, "gameId")
    
    { :ok, recent_games } = recent(region, player_id)
    
    first_recent = List.first(recent_games)
    
    assert Map.has_key?(first_recent, "championId")
      
  end
end

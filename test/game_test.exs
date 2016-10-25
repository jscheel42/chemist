defmodule GameTest do
  use ExUnit.Case
  doctest Chemist

  import Chemist.Game
  
  @api_key            Application.get_env(:chemist, :api_key)
  
  test "Return featured games" do
    region = "na"
    
    { :ok, featured_games } = featured(region)

    assert Map.has_key?(featured_games, "clientRefreshInterval")
    assert Map.has_key?(featured_games, "gameList")
    
    # Get the first game in the featured games list
    first_featured = 
      Map.fetch!(featured_games, "gameList")
      |> List.first
      
    assert Map.has_key?(first_featured, "platformId")
      
    # {status, data} = summoner(region, summoner_name)
    # assert status == :ok
    # assert Map.fetch(data, "name") == { :ok, summoner_name }
  end
end

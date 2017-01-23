defmodule LeagueTest do
  use ExUnit.Case
  doctest Chemist

  import Chemist.League
    
  test "Return master players, check player's league and entry" do
    region = "oce"
    
    # Chemist.League.master test
    
    { :ok, master_players } = master(region, %{type: "RANKED_SOLO_5x5"})
    
    assert Map.has_key?(master_players, "entries")
    
    first_master_player =
      Map.fetch!(master_players, "entries")
      |> List.first
    
    assert Map.has_key?(first_master_player, "playerOrTeamId")
    
    first_master_player_id = Map.fetch!(first_master_player, "playerOrTeamId")
    
    # Chemist.League.league_by_id test
    
    { :ok, league } = league_by_id(region, first_master_player_id)
    
    assert Map.has_key?(league, first_master_player_id)
    
    # Chemist.League.entry_by_id test
    
    { :ok, entry } = entry_by_id(region, first_master_player_id)
    
    assert Map.has_key?(entry, first_master_player_id)
    
  end
  
  test "Return challenger players" do
    region = "oce"
    
    { :ok, challenger_players } = challenger(region, %{type: "RANKED_SOLO_5x5"})
    
    assert Map.has_key?(challenger_players, "entries")
  end

end

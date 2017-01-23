defmodule StatsTest do
  use ExUnit.Case
  doctest Chemist

  import Chemist.Stats
    
  test "Return ranked by player id" do
    region = "na"
    player_id = 51666047
    
    { :ok, ranked_stats } = ranked_by_id(region, player_id)
    
    assert Map.has_key?(ranked_stats, "champions")
  end
  
  test "Return summary by player id" do
    region = "na"
    player_id = 51666047
    
    { :ok, summary } = summary_by_id(region, player_id)

    assert Map.has_key?(summary, "playerStatSummaries")
  end
end

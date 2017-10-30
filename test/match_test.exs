defmodule MatchTest do
  use ExUnit.Case
  doctest Chemist

  import Chemist.Match
  import Chemist.Util

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

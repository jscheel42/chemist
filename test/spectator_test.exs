defmodule SpectatorTest do
  use ExUnit.Case
  doctest Chemist

  import Chemist.Spectator

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
end

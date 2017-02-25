defmodule Chemist.Match do

  @api_version_match             Application.get_env(:chemist, :api_version_match)
  @api_version_matchlist         Application.get_env(:chemist, :api_version_matchlist)

  @moduledoc """
  Uses match-v#{@api_version_match} and 
  matchlist-v#{@api_version_matchlist} APIs.
  """
    
  import Chemist.Util

  @doc """
  Contains match data; retrieved by match id.

  Default opts:
  * includeTimeline: false
      * Flag indicating whether or not to include match timeline data

  Sample output:
      {:ok,
       %{"mapId" => 11, "matchCreation" => 1487968224848,
         "matchDuration" => 1904, "matchId" => 2434912258,
         "matchMode" => "CLASSIC", "matchType" => "MATCHED_GAME",
         "matchVersion" => "7.4.176.9828",
         "participantIdentities" => [%{"participantId" => 1,
            "player" => %{"matchHistoryUri" => "/v1/stats/player_history/NA1/231272990",
              "profileIcon" => 1301, "summonerId" => 72469211,
              "summonerName" => "Dubaya is Back"}},
          ...
          ],
          "participants" => [%{"championId" => 117,
             "highestAchievedSeasonTier" => "DIAMOND",
             "masteries" => [%{"masteryId" => 6211, "rank" => 5},
              %{"masteryId" => 6223, "rank" => 1},
              %{"masteryId" => 6232, "rank" => 5},
              %{"masteryId" => 6241, "rank" => 1},
              %{"masteryId" => 6311, "rank" => 5},
              %{"masteryId" => 6322, "rank" => 1},
              %{"masteryId" => 6332, "rank" => 5},
              %{"masteryId" => 6342, "rank" => 1},
              %{"masteryId" => 6352, "rank" => 5},
              %{"masteryId" => 6363, "rank" => 1}], "participantId" => 1,
             "runes" => [%{"rank" => 1, "runeId" => 5053},
              %{"rank" => 9, "runeId" => 5273},
              %{"rank" => 1, "runeId" => 5289},
              %{"rank" => 7, "runeId" => 5296},
              %{"rank" => 3, "runeId" => 5317},
              %{"rank" => 6, "runeId" => 5320},
              %{"rank" => 3, "runeId" => 5357}], "spell1Id" => 4,
             "spell2Id" => 3,
             "stats" => %{"firstInhibitorKill" => false,
               "totalDamageTaken" => 15553, "neutralMinionsKilled" => 0,
               "kills" => 0, "totalScoreRank" => 0,
               "totalTimeCrowdControlDealt" => 524, "wardsKilled" => 6,
               "physicalDamageDealt" => 7104, "towerKills" => 0,
               "trueDamageTaken" => 121, "magicDamageDealtToChampions" => 6105,
               "totalDamageDealtToChampions" => 8415, "combatPlayerScore" => 0,
               "largestKillingSpree" => 0, "sightWardsBoughtInGame" => 0,
               "item5" => 0, "firstBloodAssist" => false,
               "largestCriticalStrike" => 0, "totalHeal" => 4589,
               "visionWardsBoughtInGame" => 3, "tripleKills" => 0,
               "objectivePlayerScore" => 0, "firstTowerAssist" => false,
               "winner" => false, "trueDamageDealt" => 2049,
               "inhibitorKills" => 0, "largestMultiKill" => 0,
               "firstInhibitorAssist" => false, "item1" => 3504,
               "neutralMinionsKilledTeamJungle" => 0, "minionsKilled" => 24,
               ...}, "teamId" => 100,
             "timeline" => %{"creepsPerMinDeltas" => %{"tenToTwenty" => 1.0,
                 "twentyToThirty" => 1.2000000000000002, "zeroToTen" => 0.1},
               "csDiffPerMinDeltas" => %{"tenToTwenty" => -1.3499999999999996,
                 "twentyToThirty" => -1.1500000000000004, "zeroToTen" => -1.4},
               "damageTakenDiffPerMinDeltas" => %{"tenToTwenty" => -259.35,
                 "twentyToThirty" => -95.10000000000002,
                 "zeroToTen" => 1.049999999999983},
               "damageTakenPerMinDeltas" => %{"tenToTwenty" => 241.1,
                 "twentyToThirty" => 832.4, "zeroToTen" => 261.5},
               "goldPerMinDeltas" => %{"tenToTwenty" => 314.6,
                 "twentyToThirty" => 318.6, "zeroToTen" => 167.0},
               "lane" => "BOTTOM", "role" => "DUO_SUPPORT",
               "xpDiffPerMinDeltas" => %{"tenToTwenty" => 46.349999999999994,
                 "twentyToThirty" => -4.850000000000023,
                 "zeroToTen" => -42.40000000000002},
               "xpPerMinDeltas" => %{"tenToTwenty" => 373.8,
                 "twentyToThirty" => 611.8, "zeroToTen" => 232.4}}},
           ...
           ],
           "platformId" => "NA1", "queueType" => "TEAM_BUILDER_RANKED_SOLO",
           "region" => "NA", "season" => "PRESEASON2017",
           "teams" => [%{"bans" => [%{"championId" => 114, "pickTurn" => 1},
               %{"championId" => 164, "pickTurn" => 3},
               %{"championId" => 7, "pickTurn" => 5}], "baronKills" => 0,
              "dominionVictoryScore" => 0, "dragonKills" => 3,
              "firstBaron" => false, "firstBlood" => false,
              "firstDragon" => true, "firstInhibitor" => false,
              "firstRiftHerald" => false, "firstTower" => false,
              "inhibitorKills" => 0, "riftHeraldKills" => 0, "teamId" => 100,
              "towerKills" => 2, "vilemawKills" => 0, "winner" => false},
            %{"bans" => [%{"championId" => 17, "pickTurn" => 2},
               %{"championId" => 107, "pickTurn" => 4},
               %{"championId" => 126, "pickTurn" => 6}], "baronKills" => 1,
              "dominionVictoryScore" => 0, "dragonKills" => 1,
              "firstBaron" => true, "firstBlood" => true, "firstDragon" => false, 
              "firstInhibitor" => true, "firstRiftHerald" => false,
              "firstTower" => true, "inhibitorKills" => 3,
              "riftHeraldKills" => 0, "teamId" => 200, "towerKills" => 11,
              "vilemawKills" => 0, "winner" => true}]}}
  """

  def match_by_id(region, match_id, opts \\ %{}) do
    default_opts = %{includeTimeline: nil}

    if valid_region?(region) and valid_keys?(opts, default_opts) do
      region
      |> url_match_by_id(match_id, opts, default_opts)
      |> HTTPoison.get
      |> handle_response
    else
      {:error, "invalid request"}
    end
  end
  
  @doc """
  Contains recent matches for a player; retrieved by player id.

  Default opts:
  * championIds: no default
      * Comma-separated list of champion IDs to use for fetching games.
  * rankedQueues: no default
      * Comma-separated list of ranked queue types to use for fetching games. Non-ranked queue types will be ignored.
  * seasons: no default
      * Comma-separated list of seasons to use for fetching games.
  * beginTime: no default
      * The begin time to use for fetching games specified as epoch milliseconds.
  * endTime: no default
      * The end time to use for fetching games specified as epoch milliseconds.
  * beginIndex: no default
      * The begin index to use for fetching games.
  * endIndex: no default
      * The end index to use for fetching games.

  Sample output:
      {:ok,
       %{"endIndex" => 1097,
         "matches" => [%{"champion" => 104, "lane" => "JUNGLE",
            "matchId" => 2434387924, "platformId" => "NA1",
            "queue" => "TEAM_BUILDER_RANKED_SOLO", "region" => "NA",
            "role" => "NONE", "season" => "PRESEASON2017",
            "timestamp" => 1487920099077},
          ...
          ], "startIndex" => 0,
       "totalGames" => 1097}}
  """

  def matchlist_by_id(region, player_id, opts \\ %{}) do
    default_opts = %{championIds: nil, rankedQueues: nil, seasons: nil, beginTime: nil,
                     endTime: nil, beginIndex: nil, endIndex: nil}

    if valid_region?(region) and valid_keys?(opts, default_opts) do
      region
      |> url_matchlist_by_id(player_id, opts, default_opts)
      |> HTTPoison.get
      |> handle_response
    else
      {:error, "invalid request"}
    end
  end
  
  defp url_match_by_id(region, id, opts, default_opts) do
    base_url_region(region)
    <> "/api/lol/na/v#{@api_version_match}/match/#{id}?"
    <> url_opts(opts, default_opts)
    <> url_key()
  end

  defp url_matchlist_by_id(region, id, opts, default_opts) do
    base_url_region(region)
    <> "/api/lol/na/v#{@api_version_matchlist}/matchlist/by-summoner/#{id}?"
    <> url_opts(opts, default_opts)
    <> url_key()
  end
end

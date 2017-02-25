defmodule Chemist.Game do

  @api_version_game             Application.get_env(:chemist, :api_version_game)
  @api_version_current_game     Application.get_env(:chemist, :api_version_current_game)
  @api_version_featured_games   Application.get_env(:chemist, :api_version_featured_games)

  @moduledoc """
  Uses current-game-v#{@api_version_current_game}, 
  featured-games-v#{@api_version_featured_games}, 
  and game-v#{@api_version_game} APIs.
  """
    
  import Chemist.Util

  @doc """
  Contains game data for a player's current game; retrieved by player id.
  
  Sample output:  
      {:ok,
       %{"bannedChampions" => [%{"championId" => 114, "pickTurn" => 1,
            "teamId" => 100},
          %{"championId" => 17, "pickTurn" => 2, "teamId" => 200},
          %{"championId" => 164, "pickTurn" => 3, "teamId" => 100},
          %{"championId" => 107, "pickTurn" => 4, "teamId" => 200},
          %{"championId" => 7, "pickTurn" => 5, "teamId" => 100},
          %{"championId" => 126, "pickTurn" => 6, "teamId" => 200}],
         "gameId" => 2434912258, "gameLength" => 368, "gameMode" => "CLASSIC",
         "gameQueueConfigId" => 420, "gameStartTime" => 1487968292999,
         "gameType" => "MATCHED_GAME", "mapId" => 11,
         "observers" => %{"encryptionKey" => "MCZnljIAgQqSfRhxnSDGhsgTe3r396mj"},
         "participants" => [%{"bot" => false, "championId" => 117,
            "masteries" => [%{"masteryId" => 6211, "rank" => 5},
             %{"masteryId" => 6223, "rank" => 1},
             %{"masteryId" => 6232, "rank" => 5},
             %{"masteryId" => 6241, "rank" => 1},
             %{"masteryId" => 6311, "rank" => 5},
             %{"masteryId" => 6322, "rank" => 1},
             %{"masteryId" => 6332, "rank" => 5},
             %{"masteryId" => 6342, "rank" => 1},
             %{"masteryId" => 6352, "rank" => 5},
             %{"masteryId" => 6363, "rank" => 1}], "profileIconId" => 1301,
            "runes" => [%{"count" => 1, "runeId" => 5053},
             %{"count" => 9, "runeId" => 5273},
             %{"count" => 1, "runeId" => 5289},
             %{"count" => 7, "runeId" => 5296},
             %{"count" => 3, "runeId" => 5317},
             %{"count" => 6, "runeId" => 5320},
             %{"count" => 3, "runeId" => 5357}], "spell1Id" => 4,
            "spell2Id" => 3, "summonerId" => 72469211,
            "summonerName" => "Dubaya is Back", "teamId" => 100}, ...
  """

  def current(region, player_id) do
    if valid_region?(region) do
      region
      |> url_current(player_id)
      |> HTTPoison.get
      |> handle_response
    else
      {:error, "invalid request"}
    end
  end

  @doc """
  Contains game data for multiple featured games.
  
  Sample output:
      {:ok,
       %{"clientRefreshInterval" => 300,
         "gameList" => [%{"bannedChampions" => [], "gameId" => 2434932035,
            "gameLength" => 122, "gameMode" => "ARAM",
            "gameQueueConfigId" => 65, "gameStartTime" => 1487970919876,
            "gameType" => "MATCHED_GAME", "mapId" => 12,
            "observers" => %{"encryptionKey" => "ntCf4aznxDjgXZNWsypBIrqZTd+XwYbG"},
            "participants" => [%{"bot" => false, "championId" => 40,
               "profileIconId" => 709, "spell1Id" => 3, "spell2Id" => 4,
               "summonerName" => "Oceanman93", "teamId" => 100},
             %{"bot" => false, "championId" => 59, "profileIconId" => 551,
               "spell1Id" => 32, "spell2Id" => 4,
               "summonerName" => "Coldstream Guard", "teamId" => 100}, ...
  """

  def featured(region) do
    if valid_region?(region) do
      region
      |> url_featured
      |> HTTPoison.get
      |> handle_response
    else
      {:error, "invalid request"}
    end
  end
    
  @doc """
  Contains game data for a player's recent games; retrieved by player id.
  
  Sample Output:
      {:ok,
        %{"games" => [%{"championId" => 104, "createDate" => 1487921982640,
          "fellowPlayers" => [%{"championId" => 31, "summonerId" => 25238654, 
             "teamId" => 200},
           %{"championId" => 81, "summonerId" => 45434952, "teamId" => 100},
           %{"championId" => 13, "summonerId" => 59735223, "teamId" => 100},
           %{"championId" => 53, "summonerId" => 43095159, "teamId" => 100},
           %{"championId" => 157, "summonerId" => 71470965, "teamId" => 200}, 
           %{"championId" => 111, "summonerId" => 34173835, "teamId" => 200}, 
           %{"championId" => 64, "summonerId" => 43551883, "teamId" => 200},
           %{"championId" => 202, "summonerId" => 37304326, "teamId" => 200}, 
           %{"championId" => 17, "summonerId" => 29491836, "teamId" => 100}], 
          "gameId" => 2434387924, "gameMode" => "CLASSIC",
          "gameType" => "MATCHED_GAME", "invalid" => false,
          "ipEarned" => 235, "level" => 30, "mapId" => 11, "spell1" => 4,
          "spell2" => 11,
          "stats" => %{"totalDamageTaken" => 24174,
            "neutralMinionsKilled" => 135, "wardPlaced" => 8,
            "totalTimeCrowdControlDealt" => 536, "wardKilled" => 1,
            "trueDamageTaken" => 1187, "level" => 15,
            "magicDamageDealtToChampions" => 1552,
            "totalDamageDealtToChampions" => 14200,
            "physicalDamageDealtPlayer" => 164961,
            "largestKillingSpree" => 4, "item5" => 3134,
            "visionWardsBought" => 1, "timePlayed" => 1751,
            "playerPosition" => 3, "totalHeal" => 10792, "team" => 100,
            "bountyLevel" => 2, "trueDamageDealtPlayer" => 12858,
            "magicDamageDealtPlayer" => 5937, "largestMultiKill" => 2,
            "item1" => 1033, "minionsKilled" => 31, "turretsKilled" => 2,
            "magicDamageTaken" => 5616, "barracksKilled" => 1,
            "numDeaths" => 2, "championsKilled" => 6, "win" => true,
            "item0" => 1412, "item3" => 3047, "totalDamageDealt" => 183758,
            "trueDamageDealtToChampions" => 294,
            "neutralMinionsKilledYourJungle" => 74, ...},
          "subType" => "RANKED_SOLO_5x5", "teamId" => 100}, ...
  """

  def recent(region, player_id) do
    if valid_region?(region) do
      region
      |> url_recent(player_id)
      |> HTTPoison.get
      |> handle_response
    else
      {:error, "invalid request"}
    end
  end
  
  defp url_current(region, player_id) do
    base_url_region(region)
    <> "/observer-mode/rest/consumer/getSpectatorGameInfo/#{get_platform_id(region)}/#{player_id}?"
    <> url_key()
  end

  defp url_featured(region) do
    base_url_region(region)
    <> "/observer-mode/rest/featured?"
    <> url_key()
  end

  defp url_recent(region, player_id) do
    base_url_region(region)
    <> "/api/lol/#{region}/v#{@api_version_game}/game/by-summoner/#{player_id}/recent?"
    <> url_key()
  end

end

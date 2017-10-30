defmodule Chemist.Spectator do

  @api_version_spectator          3
  # @api_version_game             1.3
  # @api_version_current_game     1.0
  # @api_version_featured_games   1.0

  @moduledoc """
  Uses spectator-v#{@api_version_spectator} API
  """

  import Chemist.Util

  # @doc """
  # Contains game data for a player's current game; retrieved by player id.
  #
  # Sample output:
  #     {:ok,
  #      %{"bannedChampions" => [%{"championId" => 114, "pickTurn" => 1,
  #           "teamId" => 100},
  #         %{"championId" => 17, "pickTurn" => 2, "teamId" => 200},
  #         %{"championId" => 164, "pickTurn" => 3, "teamId" => 100},
  #         %{"championId" => 107, "pickTurn" => 4, "teamId" => 200},
  #         %{"championId" => 7, "pickTurn" => 5, "teamId" => 100},
  #         %{"championId" => 126, "pickTurn" => 6, "teamId" => 200}],
  #        "gameId" => 2434912258, "gameLength" => 368, "gameMode" => "CLASSIC",
  #        "gameQueueConfigId" => 420, "gameStartTime" => 1487968292999,
  #        "gameType" => "MATCHED_GAME", "mapId" => 11,
  #        "observers" => %{"encryptionKey" => "MCZnljIAgQqSfRhxnSDGhsgTe3r396mj"},
  #        "participants" => [%{"bot" => false, "championId" => 117,
  #           "masteries" => [%{"masteryId" => 6211, "rank" => 5},
  #            %{"masteryId" => 6223, "rank" => 1},
  #            %{"masteryId" => 6232, "rank" => 5},
  #            %{"masteryId" => 6241, "rank" => 1},
  #            %{"masteryId" => 6311, "rank" => 5},
  #            %{"masteryId" => 6322, "rank" => 1},
  #            %{"masteryId" => 6332, "rank" => 5},
  #            %{"masteryId" => 6342, "rank" => 1},
  #            %{"masteryId" => 6352, "rank" => 5},
  #            %{"masteryId" => 6363, "rank" => 1}], "profileIconId" => 1301,
  #           "runes" => [%{"count" => 1, "runeId" => 5053},
  #            %{"count" => 9, "runeId" => 5273},
  #            %{"count" => 1, "runeId" => 5289},
  #            %{"count" => 7, "runeId" => 5296},
  #            %{"count" => 3, "runeId" => 5317},
  #            %{"count" => 6, "runeId" => 5320},
  #            %{"count" => 3, "runeId" => 5357}], "spell1Id" => 4,
  #           "spell2Id" => 3, "summonerId" => 72469211,
  #           "summonerName" => "Dubaya is Back", "teamId" => 100}, ...
  # """

  def current(region, player_id) do
    if valid_region?(region) do
      region
      |> url_current(player_id)
      |> httpoison_get_w_key
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
      |> httpoison_get_w_key
      |> handle_response
    else
      {:error, "invalid request"}
    end
  end

  defp url_current(region, player_id) do
    base_url_region(region)
    <> "/lol/spectator/v#{@api_version_spectator}/active-games/by-summoner/#{player_id}?"
    # <> "/observer-mode/rest/consumer/getSpectatorGameInfo/#{get_platform_id(region)}/#{player_id}?"
    # <> url_key()
  end

  defp url_featured(region) do
    base_url_region(region)
    <> "/lol/spectator/v#{@api_version_spectator}/featured-games?"
    # <> "/observer-mode/rest/featured?"
    # <> url_key()
  end

end

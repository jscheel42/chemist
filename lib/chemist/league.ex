defmodule Chemist.League do

  @api_version_league             3

  @moduledoc """
  Uses league-v#{@api_version_league} API.
  """

  import Chemist.Util

  @doc """
  Contains league positions for a summoner; retrieved by summonerId
  Reference: https://developer.riotgames.com/api-methods/#league-v3/GET_getAllLeaguePositionsForSummoner
  """

  def positions(region, summoner_id) do
    if valid_region?(region) do
      region
      |> url_positions(summoner_id)
      |> httpoison_get_w_key
      |> handle_response
    else
      {:error, "invalid request"}
    end
  end

  @doc """
  Contains league; retrieved by leagueId
  Reference: https://developer.riotgames.com/api-methods/#league-v3/GET_getLeagueById
  """

  def league(region, league_id) do
    if valid_region?(region) do
      region
      |> url_league(league_id)
      |> httpoison_get_w_key
      |> handle_response
    else
      {:error, "invalid request"}
    end
  end

  # @doc """
  # Contains all leagues for specified summoners and summoners' teams, including for teams where the player is inactive; retrieved by player id.
  #
  # Sample output:
  #     {:ok,
  #      %{"51666047" => [%{"entries" => [%{"division" => "IV",
  #              "isFreshBlood" => false, "isHotStreak" => false,
  #              "isInactive" => false, "isVeteran" => false,
  #              "leaguePoints" => 0, "losses" => 7,
  #              "playerOrTeamId" => "24883051",
  #              "playerOrTeamName" => "The Bootyologist", "wins" => 4},
  #              ...
  #              "name" => "Draven's Renegades", "participantId" => "51666047",
  #                   "queue" => "RANKED_SOLO_5x5", "tier" => "GOLD"}]}}
  # """
  #
  # def league_by_id(region, player_id) do
  #   if valid_region?(region) do
  #     region
  #     |> url_league_by_id(player_id)
  #     |> httpoison_get_w_key
  #     |> handle_response
  #   else
  #     {:error, "invalid request"}
  #   end
  # end
  #
  # @doc """
  # Contains all league entries for specified summoners and summoners' teams; retrieved by .
  #
  # Sample output:
  #     {:ok,
  #      %{"51666047" => [%{"entries" => [%{"division" => "V",
  #              "isFreshBlood" => true, "isHotStreak" => false,
  #              "isInactive" => false, "isVeteran" => false,
  #              "leaguePoints" => 21, "losses" => 133,
  #              "playerOrTeamId" => "51666047",
  #              "playerOrTeamName" => "jrizznezz", "wins" => 139}],
  #           "name" => "Draven's Renegades", "queue" => "RANKED_SOLO_5x5",
  #           "tier" => "GOLD"}]}}
  # """
  #
  # def entry_by_id(region, player_id) do
  #   if valid_region?(region) do
  #     region
  #     |> url_entry_by_id(player_id)
  #     |> httpoison_get_w_key
  #     |> handle_response
  #   else
  #     {:error, "invalid request"}
  #   end
  # end

  @doc """
  Contains league entries for the challenger league.

  Possible values for type:
  * RANKED_SOLO_5x5
  * RANKED_FLEX_SR
  * RANKED_FLEX_TT

  Sample output:
      {:ok,
       %{"entries" => [%{"division" => "I", "isFreshBlood" => true,
            "isHotStreak" => true, "isInactive" => false, "isVeteran" => false,
            "leaguePoints" => 0, "losses" => 18,
            "playerOrTeamId" => "25270227", "playerOrTeamName" => "DusKRaptor",
            "wins" => 43},
            ...
            "name" => "Poppy's Paladins", "queue" => "RANKED_FLEX_SR",
            "tier" => "CHALLENGER"}}
  """

  def challenger(region, type) do
    if valid_region?(region) do
      region
      |> url_challenger(type)
      |> httpoison_get_w_key
      |> handle_response
    else
      {:error, "invalid request"}
    end
  end

  @doc """
  Contains league entries for the master league.

  Possible values for type:
  * RANKED_SOLO_5x5
  * RANKED_FLEX_SR
  * RANKED_FLEX_TT

  Sample output:
      {:ok,
       %{"entries" => [%{"division" => "I", "isFreshBlood" => true,
            "isHotStreak" => false, "isInactive" => false,
            "isVeteran" => false, "leaguePoints" => 0, "losses" => 36,
            "playerOrTeamId" => "38809624",
            "playerOrTeamName" => "Sophist Sage", "wins" => 49}],
            ...
         "name" => "Darius's Blackguards", "queue" => "RANKED_FLEX_SR",
         "tier" => "MASTER"}}
  """

  def master(region, type) do
    if valid_region?(region) do
      region
      |> url_master(type)
      |> httpoison_get_w_key
      |> handle_response
    else
      {:error, "invalid request"}
    end
  end

  # defp url_league_by_id(region, player_id) do
  #   base_url_region(region)
  #   <> "/api/lol/#{region}/v#{@api_version_league}/league/by-summoner/#{player_id}?"
  #   <> url_key()
  # end
  #
  # defp url_entry_by_id(region, player_id) do
  #   base_url_region(region)
  #   <> "/api/lol/#{region}/v#{@api_version_league}/league/by-summoner/#{player_id}/entry?"
  #   <> url_key()
  # end

  defp url_positions(region, summoner_id) do
    base_url_region(region)
    <> "/lol/league/v#{@api_version_league}/positions/by-summoner/#{summoner_id}?"
  end

  defp url_league(region, league_id) do
    base_url_region(region)
    <> "/lol/league/v#{@api_version_league}/leagues/#{league_id}?"
    # <> "/lol/league/v#{@api_version_league}/positions/by-summoner/#{url_league}?"
  end

  defp url_challenger(region, type) do
    base_url_region(region)
    <> "/lol/league/v#{@api_version_league}/challengerleagues/by-queue/#{type}?"
  end

  defp url_master(region, type) do
    base_url_region(region)
    <> "/lol/league/v#{@api_version_league}/masterleagues/by-queue/#{type}?"
  end

end

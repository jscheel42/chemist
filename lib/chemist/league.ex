defmodule Chemist.League do

  @api_version_league             2.5

  @moduledoc """
  Uses league-v#{@api_version_league} API.
  """
    
  import Chemist.Util

  @doc """
  Contains all leagues for specified summoners and summoners' teams, including for teams where the player is inactive; retrieved by player id.
  
  Sample output:
      {:ok,
       %{"51666047" => [%{"entries" => [%{"division" => "IV",
               "isFreshBlood" => false, "isHotStreak" => false,
               "isInactive" => false, "isVeteran" => false,
               "leaguePoints" => 0, "losses" => 7,
               "playerOrTeamId" => "24883051",
               "playerOrTeamName" => "The Bootyologist", "wins" => 4},
               ...
               "name" => "Draven's Renegades", "participantId" => "51666047",
                    "queue" => "RANKED_SOLO_5x5", "tier" => "GOLD"}]}}
  """

  def league_by_id(region, player_id) do
    if valid_region?(region) do
      region
      |> url_league_by_id(player_id)
      |> HTTPoison.get
      |> handle_response
    else
      {:error, "invalid request"}
    end
  end

  @doc """
  Contains all league entries for specified summoners and summoners' teams; retrieved by .
  
  Sample output:
      {:ok,
       %{"51666047" => [%{"entries" => [%{"division" => "V",
               "isFreshBlood" => true, "isHotStreak" => false,
               "isInactive" => false, "isVeteran" => false,
               "leaguePoints" => 21, "losses" => 133,
               "playerOrTeamId" => "51666047",
               "playerOrTeamName" => "jrizznezz", "wins" => 139}],
            "name" => "Draven's Renegades", "queue" => "RANKED_SOLO_5x5",
            "tier" => "GOLD"}]}}
  """

  def entry_by_id(region, player_id) do
    if valid_region?(region) do
      region
      |> url_entry_by_id(player_id)
      |> HTTPoison.get
      |> handle_response
    else
      {:error, "invalid request"}
    end
  end
  
  @doc """
  Contains league entries for the challenger league.

  Default opts:
  * type: "RANKED_FLEX_SR"
      * Type of matchmaking
      * Possible values:
          * RANKED_FLEX_TT
          * RANKED_SOLO_5x5
          * RANKED_TEAM_3x3
          * RANKED_TEAM_5x5

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

  def challenger(region, opts \\ %{}) do
    default_opts = %{type: "RANKED_FLEX_SR"}
    
    if valid_region?(region) and valid_keys?(opts, default_opts) do
      region
      |> url_challenger(opts, default_opts)
      |> HTTPoison.get
      |> handle_response
    else
      {:error, "invalid request"}
    end
  end
  
  @doc """
  Contains league entries for the master league.
  
  Default opts:
  * type: "RANKED_FLEX_SR"
      * Type of matchmaking
      * Possible values:
          * RANKED_FLEX_TT
          * RANKED_SOLO_5x5
          * RANKED_TEAM_3x3
          * RANKED_TEAM_5x5

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

  def master(region, opts \\ %{}) do
    default_opts = %{type: "RANKED_FLEX_SR"}
    
    if valid_region?(region) and valid_keys?(opts, default_opts) do
      region
      |> url_master(opts, default_opts)
      |> HTTPoison.get
      |> handle_response
    else
      {:error, "invalid request"}
    end
  end
  
  defp url_league_by_id(region, player_id) do
    base_url_region(region)
    <> "/api/lol/#{region}/v#{@api_version_league}/league/by-summoner/#{player_id}?"
    <> url_key()
  end

  defp url_entry_by_id(region, player_id) do
    base_url_region(region)
    <> "/api/lol/#{region}/v#{@api_version_league}/league/by-summoner/#{player_id}/entry?"
    <> url_key()
  end

  defp url_challenger(region, opts, default_opts) do
    base_url_region(region)
    <> "/api/lol/#{region}/v#{@api_version_league}/league/challenger?"
    <> url_opts(opts, default_opts)
    <> url_key()
  end

  defp url_master(region, opts, default_opts) do
    base_url_region(region)
    <> "/api/lol/#{region}/v#{@api_version_league}/league/master?"
    <> url_opts(opts, default_opts)
    <> url_key()
  end

end

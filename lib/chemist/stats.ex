defmodule Chemist.Stats do

  @api_version_stats             1.3

  @moduledoc """
  Uses stats-v#{@api_version_stats} API.
  """
    
  import Chemist.Util

  @doc """
  Contains ranked stats information; retrieved by summoner id.

  Default opts:
  * season: defaults to current season
      * Specifies ranked season from which to gather data.
      * Possible values:
          * SEASON3
          * SEASON2014
          * SEASON2015
          * SEASON2016
          * SEASON2017

  Sample output:
      {:ok,
       %{"champions" => [%{"id" => 75,
            "stats" => %{"maxChampionsKilled" => 6, "maxNumDeaths" => 7,
              "mostChampionKillsPerSession" => 6, "mostSpellsCast" => 0,
              "totalAssists" => 22, "totalChampionKills" => 18,
              "totalDamageDealt" => 465145, "totalDamageTaken" => 124065,
              "totalDeathsPerSession" => 20, "totalDoubleKills" => 1,
              "totalFirstBlood" => 0, "totalGoldEarned" => 47122,
              "totalMagicDamageDealt" => 251986, "totalMinionKills" => 710,
              "totalPentaKills" => 0, "totalPhysicalDamageDealt" => 211682,
              "totalQuadraKills" => 0, "totalSessionsLost" => 3,
              "totalSessionsPlayed" => 4, "totalSessionsWon" => 1,
              "totalTripleKills" => 0, "totalTurretsKilled" => 1,
              "totalUnrealKills" => 0}},
          ...
          ],
          "modifyDate" => 1488042401000, "summonerId" => 51666047}}
  """

  def ranked(region, summoner_id, opts \\ %{}) do
    default_opts = %{season: nil}

    if valid_region?(region) and valid_keys?(opts, default_opts) do
      region
      |> url_ranked(summoner_id, opts, default_opts)
      |> HTTPoison.get
      |> handle_response
    else
      {:error, "invalid request"}
    end
  end

  @doc """
  Contains player stats summary information; retrieved by summoner id.

  Default opts:
  * season: defaults to current season
      * Specifies ranked season from which to gather data.
      * Possible values:
          * SEASON3
          * SEASON2014
          * SEASON2015
          * SEASON2016
          * SEASON2017

  Sample output:
      {:ok,
       %{"playerStatSummaries" => [%{"aggregatedStats" => %{"totalAssists" => 40,
              "totalChampionKills" => 42, "totalMinionKills" => 920,
              "totalNeutralMinionsKilled" => 29, "totalTurretsKilled" => 3},
            "modifyDate" => 1481137880000, "playerStatSummaryType" => "CAP5x5", 
            "wins" => 5},
        ...
        ],
        "summonerId" => 51666047}}
  """
  
  def summary(region, summoner_id, opts \\ %{}) do
    default_opts = %{season: nil}

    if valid_region?(region) and valid_keys?(opts, default_opts) do
      region
      |> url_summary(summoner_id, opts, default_opts)
      |> HTTPoison.get
      |> handle_response
    else
      {:error, "invalid request"}
    end
  end
    
  defp url_ranked(region, id, opts, default_opts) do
    base_url_region(region)
    <> "/api/lol/na/v#{@api_version_stats}/stats/by-summoner/#{id}/ranked?"
    <> url_opts(opts, default_opts)
    <> url_key()
  end

  defp url_summary(region, id, opts, default_opts) do
    base_url_region(region)
    <> "/api/lol/na/v#{@api_version_stats}/stats/by-summoner/#{id}/summary?"
    <> url_opts(opts, default_opts)
    <> url_key()
  end

end

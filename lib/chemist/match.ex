defmodule Chemist.Match do

  @moduledoc """
  Retrieve league data from Riot API
  and transform it into an Elixir friendly format
  """
    
  import Chemist.Util

  @api_version_match             Application.get_env(:chemist, :api_version_match)
  @api_version_matchlist         Application.get_env(:chemist, :api_version_matchlist)
    
  def match_by_id(region, id, opts \\ %{}) do
    default_opts = %{includeTimeline: nil}

    if valid_region?(region) and valid_keys?(opts, default_opts) do
      region
      |> url_match_by_id(id, opts, default_opts)
      |> HTTPoison.get
      |> handle_response
    else
      {:error, "invalid request"}
    end
  end
  
  def matchlist_by_id(region, id, opts \\ %{}) do
    default_opts = %{championIds: nil, rankedQueues: nil, seasons: nil, beginTime: nil,
                     endTime: nil, beginIndex: nil, endIndex: nil}

    if valid_region?(region) and valid_keys?(opts, default_opts) do
      region
      |> url_matchlist_by_id(id, opts, default_opts)
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

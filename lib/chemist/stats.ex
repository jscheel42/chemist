defmodule Chemist.Stats do

  @moduledoc """
  Retrieve league data from Riot API
  and transform it into an Elixir friendly format
  """
    
  import Chemist.Util

  @api_version_stats             Application.get_env(:chemist, :api_version_stats)
    
  def ranked_by_id(region, id, opts \\ %{}) do
    default_opts = %{season: nil}

    if valid_region?(region) and valid_keys?(opts, default_opts) do
      region
      |> url_ranked_by_id(id, opts, default_opts)
      |> HTTPoison.get
      |> handle_response
    else
      {:error, "invalid request"}
    end
  end
    
  def summary_by_id(region, id, opts \\ %{}) do
    default_opts = %{season: nil}

    if valid_region?(region) and valid_keys?(opts, default_opts) do
      region
      |> url_summary_by_id(id, opts, default_opts)
      |> HTTPoison.get
      |> handle_response
    else
      {:error, "invalid request"}
    end
  end
    
  defp url_ranked_by_id(region, id, opts, default_opts) do
    base_url_region(region)
    <> "/api/lol/na/v#{@api_version_stats}/stats/by-summoner/#{id}/ranked?"
    <> url_opts(opts, default_opts)
    <> url_key()
  end

  defp url_summary_by_id(region, id, opts, default_opts) do
    base_url_region(region)
    <> "/api/lol/na/v#{@api_version_stats}/stats/by-summoner/#{id}/summary?"
    <> url_opts(opts, default_opts)
    <> url_key()
  end

end

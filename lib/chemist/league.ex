defmodule Chemist.League do

  @moduledoc """
  Retrieve league data from Riot API
  and transform it into an Elixir friendly format
  """
    
  import Chemist.Util

  @api_version_league             Application.get_env(:chemist, :api_version_league)

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

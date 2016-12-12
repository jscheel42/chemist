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
  
  def challenger(region, type) do
    if valid_region?(region) do
      region
      |> url_challenger(type)
      |> HTTPoison.get
      |> handle_response
    else
      {:error, "invalid request"}
    end
  end
  
  def master(region, type) do
    if valid_region?(region) do
      region
      |> url_master(type)
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

  defp url_challenger(region, type) do
    base_url_region(region)
    <> "/api/lol/#{region}/v#{@api_version_league}/league/challenger?type=#{type}&"
    <> url_key()
  end

  defp url_master(region, type) do
    base_url_region(region)
    <> "/api/lol/#{region}/v#{@api_version_league}/league/master?type=#{type}&"
    <> url_key()
  end

end

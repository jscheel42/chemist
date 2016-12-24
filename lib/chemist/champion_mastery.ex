defmodule Chemist.ChampionMastery do

  @moduledoc """
  Retrieve champion mastery data from Riot API
  and transform it into an Elixir friendly format
  """
    
  import Chemist.Util

  @doc """
  Return a tuple with the values
  { :ok, data } where data is a
  map containing champion mastery data. \n
  Uses "championmastery" API.
  """

  def champion(region, player_id, champion_id) do
    if valid_region?(region) do
      region
      |> url_champion(player_id, champion_id)
      |> HTTPoison.get
      |> handle_response
    else
      {:error, "invalid request"}
    end
  end

  @doc """
  Return a tuple with the values
  { :ok, data } where data is a
  list of maps containing champion mastery data. \n
  Uses "championmastery" API.
  """

  def champions(region, player_id) do
    if valid_region?(region) do
      region
      |> url_champions(player_id)
      |> HTTPoison.get
      |> handle_response
    else
      {:error, "invalid request"}
    end
  end
  
  @doc """
  Return a tuple with the values { :ok, data }
  where data is an integer. \n
  Uses "championmastery" API.
  """

  def score(region, player_id) do
    if valid_region?(region) do
      region
      |> url_score(player_id)
      |> HTTPoison.get
      |> handle_response
    else
      {:error, "invalid request"}
    end
  end
  
  @doc """
  Return a tuple with the values { :ok, data }
  where data is a list of maps containing champion
  mastery data for the summoner's top 3 champions by mastery score. \n
  Uses "championmastery" API.
  """

  def top_champions(region, player_id, opts \\ %{}) do
    default_opts = %{count: nil}
    
    if valid_region?(region) and valid_keys?(opts, default_opts) do
      region
      |> url_top_champions(player_id, opts, default_opts)
      |> HTTPoison.get
      |> handle_response
    else
      {:error, "invalid request"}
    end
  end
  
  defp url_champion(region, player_id, champion_id) do
    base_url_region(region)
    <> "/championmastery/location/#{get_platform_id(region)}/player/#{player_id}/champion/#{champion_id}?"
    <> url_key()
  end

  defp url_champions(region, player_id) do
    base_url_region(region)
    <> "/championmastery/location/#{get_platform_id(region)}/player/#{player_id}/champions?"
    <> url_key()
  end

  defp url_score(region, player_id) do
    base_url_region(region)
    <> "/championmastery/location/#{get_platform_id(region)}/player/#{player_id}/score?"
    <> url_key()
  end

  defp url_top_champions(region, player_id, opts, default_opts) do
    base_url_region(region)
    <> "/championmastery/location/#{get_platform_id(region)}/player/#{player_id}/topchampions?"
    <> url_opts(opts, default_opts)
    <> url_key()
  end

end

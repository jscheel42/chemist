defmodule Chemist.ChampionMastery do

  @moduledoc """
  Retrieve champion mastery data from Riot API
  and transform it into an Elixir friendly format
  """
    
  import Chemist.Util

  @api_key        Application.get_env(:chemist, :api_key)
  @user_agent     Application.get_env(:chemist, :user_agent)

  @doc """
  Return a tuple with the values
  { :ok, data } where data is a
  map containing champion mastery data
  """

  def fetch_champion(region, player_id, champion_id) do
    if valid_region?(region) do
      region
      |> url(player_id, "champion", champion_id)
      |> HTTPoison.get(@user_agent)
      |> handle_response
    else
      {:error, "invalid request"}
    end
  end

  @doc """
  Return a tuple with the values
  { :ok, data } where data is a
  list of maps containing champion mastery data
  """

  def fetch_champions(region, player_id) do
    if valid_region?(region) do
      region
      |> url(player_id, "champions")
      |> HTTPoison.get(@user_agent)
      |> handle_response
    else
      {:error, "invalid request"}
    end
  end
  
  @doc """
  Return a tuple with the values { :ok, data }
  where data is an integer
  """

  def fetch_score(region, player_id) do
    if valid_region?(region) do
      region
      |> url(player_id, "score")
      |> HTTPoison.get(@user_agent)
      |> handle_response
    else
      {:error, "invalid request"}
    end
  end
  
  @doc """
  Return a tuple with the values { :ok, data }
  where data is a list of maps containing champion
  mastery data for the summoner's top 3 champions by mastery score
  """

  def fetch_top_champions(region, player_id) do
    if valid_region?(region) do
      region
      |> url(player_id, "topchampions")
      |> HTTPoison.get(@user_agent)
      |> handle_response
    else
      {:error, "invalid request"}
    end
  end

  defp url(region, player_id, category, champion_id) do
    platform_id = get_platform_id(region)
    "https://#{region}.api.pvp.net/championmastery/location/#{platform_id}/player/#{player_id}/#{category}/#{champion_id}?api_key=#{@api_key}"
  end

  defp url(region, player_id, category) do
    platform_id = get_platform_id(region)
    "https://#{region}.api.pvp.net/championmastery/location/#{platform_id}/player/#{player_id}/#{category}?api_key=#{@api_key}"
  end

  defp handle_response({ :ok, %{status_code: 200, body: body}}) do
    { :ok, Poison.Parser.parse!(body) }
  end
  
  defp handle_response({ _,   %{status_code: _,   body: body}}) do
    { :error, Poison.Parser.parse!(body) }
  end
end

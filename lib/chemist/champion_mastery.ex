defmodule Chemist.ChampionMastery do

  @moduledoc """
  Retrieve champion mastery data from Riot API
  and transform it into an Elixir friendly format
  """
    
  import Chemist.Util

  @user_agent     Application.get_env(:chemist, :user_agent)

  @doc """
  Return a tuple with the values
  { :ok, data } where data is a
  map containing champion mastery data
  """

  def champion(region, player_id, champion_id) do
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

  def champions(region, player_id) do
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

  def score(region, player_id) do
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

  def top_champions(region, player_id) do
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
    base_url_region(region)
    <> "/championmastery/location/#{get_platform_id(region)}/player/#{player_id}/#{category}/#{champion_id}"
    <> url_key()
  end

  defp url(region, player_id, category) do
    base_url_region(region)
    <> "/championmastery/location/#{get_platform_id(region)}/player/#{player_id}/#{category}"
    <> url_key()
  end

  defp handle_response({ :ok, %{status_code: 200, body: body}}) do
    { :ok, Poison.Parser.parse!(body) }
  end
  
  defp handle_response({ _,   %{status_code: _,   body: body}}) do
    { :error, Poison.Parser.parse!(body) }
  end
end

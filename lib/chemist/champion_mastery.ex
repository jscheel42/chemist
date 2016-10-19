defmodule Chemist.ChampionMastery do

  @moduledoc """
  Retrieve champion mastery data from Riot API
  and transform it into an Elixir friendly format
  """

  @api_key        Application.get_env(:chemist, :api_key)
  @user_agent     Application.get_env(:chemist, :user_agent)

  @doc """
  Return a tuple with the values
  { :ok, data } where data is a
  map containing champion mastery data
  """

  def fetch_champion(region, platform_id, player_id, champion_id) do
    region
    |> url(platform_id, player_id, "champion", champion_id)
    |> HTTPoison.get(@user_agent)
    |> handle_response
    # |> IO.inspect
  end

  @doc """
  Return a tuple with the values
  { :ok, data } where data is a
  list of maps containing champion mastery data
  """

  def fetch_champions(region, platform_id, player_id) do
    region
    |> url(platform_id, player_id, "champions")
    |> HTTPoison.get(@user_agent)
    |> handle_response
    # |> IO.inspect
  end
  
  @doc """
  Return a tuple with the values { :ok, data }
  where data is an integer
  """

  def fetch_score(region, platform_id, player_id) do
    region
    |> url(platform_id, player_id, "score")
    |> HTTPoison.get(@user_agent)
    |> handle_response
    # |> IO.inspect
  end
  
  @doc """
  Return a tuple with the values { :ok, data }
  where data is a list of maps containing champion
  mastery data for the summoner's top 3 champions by mastery score
  """

  def fetch_top_champions(region, platform_id, player_id) do
    region
    |> url(platform_id, player_id, "topchampions")
    |> HTTPoison.get(@user_agent)
    |> handle_response
    # |> IO.inspect
  end

  @doc """
  Generate a URL based on the region, platform_id, player_id, category, champion_id
  """

  def url(region, platform_id, player_id, category, champion_id) do
    "https://#{region}.api.pvp.net/championmastery/location/#{platform_id}/player/#{player_id}/#{category}/#{champion_id}?api_key=#{@api_key}"
  end

  @doc """
  Generate a URL based on the region, platform_id, player_id, category
  """

  def url(region, platform_id, player_id, category) do
    "https://#{region}.api.pvp.net/championmastery/location/#{platform_id}/player/#{player_id}/#{category}?api_key=#{@api_key}"
  end

  @doc """
  Parse result into a tuple
  """

  def handle_response({ :ok, %{status_code: 200, body: body}}) do
    { :ok, Poison.Parser.parse!(body) }
  end
  
  def handle_response({ _,   %{status_code: _,   body: body}}) do
    { :error, Poison.Parser.parse!(body) }
  end
end

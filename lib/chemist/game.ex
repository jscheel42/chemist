defmodule Chemist.Game do

  @moduledoc """
  Retrieve game data from Riot API
  and transform it into an Elixir friendly format
  """
    
  import Chemist.Util

  @api_version_game             Application.get_env(:chemist, :api_version_game)
  @api_version_current_game     Application.get_env(:chemist, :api_version_current_game)
  @api_version_featured_games   Application.get_env(:chemist, :api_version_featured_games)

  @doc """
  Return a tuple with the values
  { :ok, data } where data is a map containing
  current game data. \n
  Uses "current-game-v#{@api_version_current_game}" API.
  """

  def current(region, player_id) do
    if valid_region?(region) do
      region
      |> url_current(player_id)
      |> HTTPoison.get
      |> handle_response
    else
      {:error, "invalid request"}
    end
  end

  @doc """
  Return a tuple with the values
  { :ok, data } where data is a map containing
  featured game data. \n
  Uses "featured-games-v#{@api_version_featured_games}" API.
  """

  def featured(region) do
    if valid_region?(region) do
      region
      |> url_featured
      |> HTTPoison.get
      |> handle_response
    else
      {:error, "invalid request"}
    end
  end
    
  @doc """
  Return a tuple with the values
  { :ok, data } where data is a list of maps
  containing the summoner's recent game data. \n
  Uses "game-v#{@api_version_game}" API.
  """

  def recent(region, player_id) do
    if valid_region?(region) do
      region
      |> url_recent(player_id)
      |> HTTPoison.get
      |> handle_response
    else
      {:error, "invalid request"}
    end
  end
  
  defp url_current(region, player_id) do
    base_url_region(region)
    <> "/observer-mode/rest/consumer/getSpectatorGameInfo/#{get_platform_id(region)}/#{player_id}"
    <> url_key()
  end

  defp url_featured(region) do
    base_url_region(region)
    <> "/observer-mode/rest/featured"
    <> url_key()
  end

  defp url_recent(region, player_id) do
    base_url_region(region)
    <> "/api/lol/#{region}/v#{@api_version_game}/game/by-summoner/#{player_id}/recent"
    <> url_key()
  end

end

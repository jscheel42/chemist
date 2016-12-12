defmodule Chemist.Champion do

  @moduledoc """
  Retrieve champion data from Riot API
  and transform it into an Elixir
  friendly format
  """

  import Chemist.Util

  @api_version_champion    Application.get_env(:chemist, :api_version_champion)
  
  @doc """
  Return a tuple with the values
  { :ok, data } where data is a
  map containing data for found champion. \n
  Uses "champion-v#{@api_version_champion}" API.
  """
  
  def champion(region, champion_id) do
    if valid_region?(region) do
      region
      |> url(champion_id)
      |> HTTPoison.get
      |> handle_response
    else
      {:error, "invalid request"}
    end
  end

  @doc """
  Return a tuple with the values
  { :ok, data } where data is a
  list of maps containing champion data. \n
  Uses "champion-v#{@api_version_champion}" API.
  """

  def champions(region) do
    if valid_region?(region) do
      region
      |> url
      |> HTTPoison.get
      |> handle_response
    else
      {:error, "invalid request"}
    end
  end

  defp url(region) do
    base_url_region(region)
    <> "/api/lol/#{region}/v#{@api_version_champion}/champion?"
    <> url_key()
  end
  
  defp url(region, champion_id) do
    base_url_region(region)
    <> "/api/lol/#{region}/v#{@api_version_champion}/champion/#{champion_id}?"
    <> url_key()
  end

end

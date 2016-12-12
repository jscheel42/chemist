defmodule Chemist.Summoner do

  @moduledoc """
  Retrieve summoner data from Riot API
  and transform it into an Elixir
  friendly format
  """

  import Chemist.Util

  @api_version_summoner    Application.get_env(:chemist, :api_version_summoner)

  @doc """
  Return a tuple with the values
  { :ok, data } where data
  is a map of returned summoner attributes. \n
  Uses "summoner-v#{@api_version_summoner} API."
  """

  def summoner_by_name(region, summoner) do
    if String.match?(summoner, ~r/^[0-9\p{L} _\.]+$/) and valid_region?(region) do
      region
      |> url_summoner_by_name(remove_spaces(summoner))
      |> HTTPoison.get
      |> handle_response
    else
      {:error, "invalid request"}
    end
  end
  
  def summoner_by_id(region, id) do
    if valid_region?(region) do
      region
      |> url_summoner_by_id(id)
      |> HTTPoison.get
      |> handle_response     
    else
      {:error, "invalid request"}
    end
  end
  
  def masteries_by_id(region, id) do
    if valid_region?(region) do
      region
      |> url_masteries_by_id(id)
      |> HTTPoison.get
      |> handle_response      
    else
      {:error, "invalid request"}
    end
  end

  def name_by_id(region, id) do
    if valid_region?(region) do
      region
      |> url_name_by_id(id)
      |> HTTPoison.get
      |> handle_response      
    else
      {:error, "invalid request"}
    end
  end

  def runes_by_id(region, id) do
    if valid_region?(region) do
      region
      |> url_runes_by_id(id)
      |> HTTPoison.get
      |> handle_response      
    else
      {:error, "invalid request"}
    end
  end

  def id_by_name(region, name) do
    { :ok, summoner_data } = summoner_by_name(region, name)
    
    summoner_data
      |> strip_key!
      |> Map.fetch!("id")
  end

  defp remove_spaces(str), do: String.replace(str, " ", "")
  
  defp url_summoner_by_name(region, summoner) do
    base_url_region(region)
    <> "/api/lol/#{region}/v#{@api_version_summoner}/summoner/by-name/#{summoner}?"
    <> url_key()
  end

  defp url_summoner_by_id(region, id) do
    base_url_region(region)
    <> "/api/lol/#{region}/v#{@api_version_summoner}/summoner/#{id}?"
    <> url_key()
  end
  
  defp url_masteries_by_id(region, id) do
    base_url_region(region)
    <> "/api/lol/#{region}/v#{@api_version_summoner}/summoner/#{id}/masteries?"
    <> url_key()
  end
  
  defp url_name_by_id(region, id) do
    base_url_region(region)
    <> "/api/lol/#{region}/v#{@api_version_summoner}/summoner/#{id}/name?"
    <> url_key()
  end
  
  defp url_runes_by_id(region, id) do
    base_url_region(region)
    <> "/api/lol/#{region}/v#{@api_version_summoner}/summoner/#{id}/runes?"
    <> url_key()
  end
end

defmodule Chemist.Champion do

  @moduledoc """
  Retrieve champion data from Riot API
  and transform it into an Elixir
  friendly format
  """

  import Chemist.Util

  @api_key        Application.get_env(:chemist, :api_key)
  @api_version    Application.get_env(:chemist, :api_version_champion)
  @user_agent     Application.get_env(:chemist, :user_agent)
  
  @doc """
  Return a tuple with the values
  { :ok, data } where data is a
  map containing data for found champion
  """
  
  def fetch(region, champion_id) do
    if valid_region?(region) do
      region
      |> url(champion_id)
      |> HTTPoison.get(@user_agent)
      |> handle_response
    else
      {:error, "invalid request"}
    end
  end

  @doc """
  Return a tuple with the values
  { :ok, data } where data is a
  list of maps containing champion data
  """

  def fetch_all(region) do
    if valid_region?(region) do
      region
      |> url
      |> HTTPoison.get(@user_agent)
      |> handle_response_all
    else
      {:error, "invalid request"}
    end
  end

  defp url(region) do
    "https://#{region}.api.pvp.net/api/lol/#{region}/v#{@api_version}/champion?api_key=#{@api_key}"
  end
  
  defp url(region, champion_id) do
    "https://#{region}.api.pvp.net/api/lol/#{region}/v#{@api_version}/champion/#{champion_id}?api_key=#{@api_key}"
  end

  defp handle_response_all({ :ok, %{status_code: 200, body: body}}) do
    Map.fetch(Poison.Parser.parse!(body), "champions")
  end

  defp handle_response_all({ _,   %{status_code: _,   body: body}}) do
    { :error, Poison.Parser.parse!(body) }
  end

  defp handle_response({ :ok, %{status_code: 200, body: body}}) do
    { :ok, Poison.Parser.parse!(body) }
  end

  defp handle_response({ _,   %{status_code: _,   body: body}}) do
    { :error, Poison.Parser.parse!(body) }
  end
end

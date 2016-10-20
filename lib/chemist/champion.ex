defmodule Chemist.Champion do

  @moduledoc """
  Retrieve champion data from Riot API
  and transform it into an Elixir
  friendly format
  """

  import Chemist.Util

  @api_version    Application.get_env(:chemist, :api_version_champion)
  
  @doc """
  Return a tuple with the values
  { :ok, data } where data is a
  map containing data for found champion
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
  list of maps containing champion data
  """

  def champions(region) do
    if valid_region?(region) do
      region
      |> url
      |> HTTPoison.get
      |> handle_response_all
    else
      {:error, "invalid request"}
    end
  end

  defp url(region) do
    base_url_region(region)
    <> "/api/lol/#{region}/v#{@api_version}/champion"
    <> url_key()
  end
  
  defp url(region, champion_id) do
    base_url_region(region)
    <> "/api/lol/#{region}/v#{@api_version}/champion/#{champion_id}"
    <> url_key()
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

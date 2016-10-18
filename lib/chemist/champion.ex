defmodule Chemist.Champion do

  @moduledoc """
  Retrieve champion data from Riot API
  and transform it into an Elixir
  friendly format
  """

  @api_key        Application.get_env(:chemist, :api_key)
  @api_version    Application.get_env(:chemist, :api_version_champion)
  @user_agent     Application.get_env(:chemist, :user_agent)

  @doc """
  Return a tuple with the values
  { :ok, data } where data is a
  list of maps containing champion data
  """

  def fetch_all(region) do
    region
    |> url
    |> HTTPoison.get(@user_agent)
    |> handle_response_all
  end
  
  @doc """
  Return a tuple with the values
  { :ok, data } where data is a
  map containing data for found champion
  """
  
  def fetch(champion_id, region) do
    champion_id
    |> url(region)
    |> HTTPoison.get(@user_agent)
    |> handle_response
  end

  @doc """
  Generate a URL based on the region
  """

  def url(region) do
    "https://#{region}.api.pvp.net/api/lol/#{region}/v#{@api_version}/champion?api_key=#{@api_key}"
  end
  
  @doc """
  Generate a URL based on the champion id and region
  """

  def url(champion_id, region) do
    "https://#{region}.api.pvp.net/api/lol/#{region}/v#{@api_version}/champion/#{champion_id}?api_key=#{@api_key}"
  end

  @doc """
  Make HTTP request and transform result
  into a tuple (all champions).
  """

  def handle_response_all({ :ok, %{status_code: 200, body: body}}) do
    Map.fetch(Poison.Parser.parse!(body), "champions")
  end

  def handle_response_all({ _,   %{status_code: _,   body: body}}) do
    { :error, Poison.Parser.parse!(body) }
  end

  @doc """
  Make HTTP request and transform result
  into a tuple (one champion).
  """

  def handle_response({ :ok, %{status_code: 200, body: body}}) do
    { :ok, Poison.Parser.parse!(body) }
  end

  def handle_response({ _,   %{status_code: _,   body: body}}) do
    { :error, Poison.Parser.parse!(body) }
  end
end

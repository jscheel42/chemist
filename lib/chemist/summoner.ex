defmodule Chemist.Summoner do

  @moduledoc """
  Retrieve summoner data from Riot API
  and transform it into an Elixir
  friendly format
  """

  @api_key        Application.get_env(:chemist, :api_key)
  @api_version    Application.get_env(:chemist, :api_version_summoner)
  @user_agent     Application.get_env(:chemist, :user_agent)

  @doc """
  Return a tuple with the values
  { :ok, shortname, data } where data
  is a map of returned summoner attributes
  """

  def fetch(summoner, region) do
    if String.match?(summoner, ~r/^[0-9\p{L} _\.]+$/) do
      summoner
      |> remove_spaces
      |> url(region)
      |> HTTPoison.get(@user_agent)
      |> handle_response
    else
      {:error, "invalid summoner name"}
    end
  end

  @doc """
  Remove spaces from a string
  """

  def remove_spaces(str), do: String.replace(str, " ", "")

  @doc """
  Generate a URL based on the region, api version, and api key
  """
  
  def url(summoner, region) do
    "https://#{region}.api.pvp.net/api/lol/#{region}/v#{@api_version}/summoner/by-name/#{summoner}?api_key=#{@api_key}"
  end

  @doc """
  Make HTTP request and transform result
  into a tuple.
  """

  def handle_response({ :ok, %{status_code: 200, body: body}}) do
    poisoned_body = Poison.Parser.parse!(body)
    
    shortname = 
      Map.keys(poisoned_body)
      |> List.first
    
    { :ok, data } = Map.fetch(poisoned_body, shortname)
    
    { :ok, shortname, data }
  end

  def handle_response({ _,   %{status_code: _,   body: body}}) do
    { :error, Poison.Parser.parse!(body) }
  end
end

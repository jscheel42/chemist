defmodule Chemist.Summoner do

  @moduledoc """
  Retrieve summoner data from Riot API
  and transform it into an Elixir
  friendly format
  """

  import Chemist.Util

  @api_version    Application.get_env(:chemist, :api_version_summoner)
  @user_agent     Application.get_env(:chemist, :user_agent)

  @doc """
  Return a tuple with the values
  { :ok, shortname, data } where data
  is a map of returned summoner attributes
  """

  def summoner(region, summoner) do
    if String.match?(summoner, ~r/^[0-9\p{L} _\.]+$/) and valid_region?(region) do
      region
      |> url(remove_spaces(summoner))
      |> HTTPoison.get
      |> handle_response
    else
      {:error, "invalid request"}
    end
  end

  # |> HTTPoison.get(@user_agent)

  defp remove_spaces(str), do: String.replace(str, " ", "")
  
  defp url(region, summoner) do
    base_url_region(region)
    <> "/api/lol/#{region}/v#{@api_version}/summoner/by-name/#{summoner}"
    <> url_key()
  end

  defp handle_response({ :ok, %{status_code: 200, body: body}}) do
    poisoned_body = Poison.Parser.parse!(body)
    
    shortname = 
      Map.keys(poisoned_body)
      |> List.first
    
    { :ok, data } = Map.fetch(poisoned_body, shortname)
    
    { :ok, shortname, data }
  end

  defp handle_response({ _,   %{status_code: _,   body: body}}) do
    { :error, Poison.Parser.parse!(body) }
  end
end

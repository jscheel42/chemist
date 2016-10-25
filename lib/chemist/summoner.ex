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

  def summoner(region, summoner) do
    if String.match?(summoner, ~r/^[0-9\p{L} _\.]+$/) and valid_region?(region) do
      region
      |> url(remove_spaces(summoner))
      |> HTTPoison.get
      |> handle_response_strip_key
    else
      {:error, "invalid request"}
    end
  end

  defp remove_spaces(str), do: String.replace(str, " ", "")
  
  defp url(region, summoner) do
    base_url_region(region)
    <> "/api/lol/#{region}/v#{@api_version_summoner}/summoner/by-name/#{summoner}"
    <> url_key()
  end

end

defmodule Chemist.Summoner do
  @api_key        Application.get_env(:chemist, :api_key)
  @api_version    Application.get_env(:chemist, :api_version_summoner)
  @user_agent     [ {"User-agent", "Chemist jscheel42@gmail.com"} ]

  def fetch(summoner, region \\ "na") do
    if String.match?(summoner, ~r/^[0-9\p{L} _\.]+$/) do
      summoner
      |> remove_spaces
      |> summoner_url(region)
      |> HTTPoison.get(@user_agent)
      |> handle_response
    else
      {:error, "invalid summoner name"}
    end
  end

  def remove_spaces(str), do: String.replace(str, " ", "")

  def summoner_url(summoner, region) do
    "https://#{region}.api.pvp.net/api/lol/#{region}/v#{@api_version}/summoner/by-name/#{summoner}?api_key=#{@api_key}"
  end

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

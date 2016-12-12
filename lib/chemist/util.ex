defmodule Chemist.Util do

  @api_key                  Application.get_env(:chemist, :api_key)
  @regions_and_platform_ids %{
    br: "BR1",
    eune: "EUN1",
    euw: "EUW1",
    kr: "KR",
    lan: "LA1",
    las: "LA2",
    na: "NA1",
    oce: "OC1",
    tr: "TR1",
    ru: "RU",
    pbe: "PBE1"
  }
  
  def valid_region?(region) do
    Map.has_key?(@regions_and_platform_ids, String.to_atom(region))
  end
  
  def get_platform_id(region) do
    { :ok, platform_id } = Map.fetch(@regions_and_platform_ids, String.to_atom(region))
    platform_id
  end
  
  def base_url_region(region) do
    "https://" <> region <> ".api.pvp.net"
  end
  
  def base_url_status() do
    "http://status.leagueoflegends.com"
  end
  
  def base_url_global() do
    "https://global.api.pvp.net"
  end
  
  def url_key() do
    "?api_key=" <> @api_key
  end
  
  def strip_key(map) do
    striped_key = 
      Map.keys(map)
      |> List.first
    
    Map.fetch(map, striped_key)   
  end
  
  def strip_key!(map) do
    { :ok, data } = strip_key(map)
    data
  end
  
  def handle_response({ :ok, %{status_code: 200, body: body}}) do
    { :ok, Poison.Parser.parse!(body) }
  end
  
  def handle_response({ _,   %{status_code: _,   body: body}}) do
    { :error, Poison.Parser.parse!(body) }
  end
    
end

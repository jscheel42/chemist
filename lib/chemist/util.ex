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

end

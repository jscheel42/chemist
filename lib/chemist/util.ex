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
  
  # Return true if all keys in check_map exist in the allowed_map
  def valid_keys?(check_map, allowed_map) do
    check_keys = Map.keys(check_map)
    allowed_keys = Map.keys(allowed_map)
    
    Enum.empty?(check_keys -- allowed_keys)
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
    "api_key=" <> @api_key
  end

  def url_opts(map, defaults) do
    merge_defaults(map, defaults)
    |> remove_nils
    |> gen_opt_list
    |> concat_opts
  end
  
  def create_example(sample) do
    IO.inspect sample
    |> to_string
  end
    
  # Merge map with defaults, use defaults where no value assigned to key
  defp merge_defaults(map, defaults) do
    Map.merge(defaults, map, fn _key, default, val -> val || default end)
  end
  
  # Removes entries with nil values, returns a list of tuples
  defp remove_nils(map) do
    Enum.filter map, fn { _key, val } -> val end
  end
  
  # Transform opts into rest friendly strings
  defp gen_opt_list(list) do
    Enum.reduce list, [], fn { key, val }, acc ->
      acc ++ ["#{key}=#{val}"]
    end
  end
  
  # Combine opts into a single string
  defp concat_opts(list) do
    Enum.join(list, "&") <> "&"
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

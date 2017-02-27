defmodule Chemist.Util do

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

  @doc """
  Returns true is the region is valid.
  """

  def valid_region?(region) do
    Map.has_key?(@regions_and_platform_ids, String.to_atom(region))
  end

  @doc """
  Return true if all keys in check_map exist in the allowed_map
  """

  def valid_keys?(check_map, allowed_map) do
    check_keys = Map.keys(check_map)
    allowed_keys = Map.keys(allowed_map)
    
    Enum.empty?(check_keys -- allowed_keys)
  end  

  @doc """
  Returns platform id based on the region
  """

  def get_platform_id(region) do
    { :ok, platform_id } = Map.fetch(@regions_and_platform_ids, String.to_atom(region))
    platform_id
  end

  @doc """
  Returns the base url based on region
  """

  def base_url_region(region) do
    "https://" <> region <> ".api.pvp.net"
  end

  @doc """
  Returns the global url
  """

  def base_url_global() do
    "https://global.api.pvp.net"
  end

  @doc """
  Returns the api_key in REST format, set via environmental variable "RIOT_API_KEY"
  """

  def url_key() do
    "api_key=" <> System.get_env("RIOT_API_KEY")
  end

  @doc """
  Returns a map with the first key removed to flatten data structure.
  Return format is {:ok, data}
  """

  def strip_key(map) do
    striped_key = 
      Map.keys(map)
      |> List.first
    
    Map.fetch(map, striped_key)   
  end

  @doc """
  Returns a map with the first key removed to flatten data structure
  """

  def strip_key!(map) do
    { :ok, data } = strip_key(map)
    data
  end

  @doc """
  Verifies the requested options are valid and formats them for REST api.
  """

  def url_opts(map, defaults) do
    merge_defaults(map, defaults)
    |> remove_nils
    |> gen_opt_list
    |> concat_opts
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

  @doc """
  Handles and transforms response from API.
  """

  def handle_response({ :ok, %{status_code: 200, body: body}}) do
    { :ok, Poison.Parser.parse!(body) }
  end
  
  def handle_response({ _,   %{status_code: _,   body: body}}) do
    { :error, Poison.Parser.parse!(body) }
  end
    
end

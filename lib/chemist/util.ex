defmodule Chemist.Util do

  # regions and platforms based on https://developer.riotgames.com/regional-endpoints.html
  @regions_and_platform_ids %{
    br: %{
      platform: "BR1",
      url: "https://br1.api.riotgames.com"
    },
    eune: %{
      platform: "EUN1",
      url: "https://eun1.api.riotgames.com"
    },
    euw: %{
      platform: "EUW1",
      url: "https://euw1.api.riotgames.com"
    },
    jp: %{
      platform: "JP1",
      url: "https://jp1.api.riotgames.com"
    },
    kr: %{
      platform: "KR",
      url: "https://kr.api.riotgames.com"
    },
    lan: %{
      platform: "LA1",
      url: "https://la1.api.riotgames.com"
    },
    las: %{
      platform: "LA2",
      url: "https://la2.api.riotgames.com"
    },
    na: %{
      platform: "NA1",
      url: "https://na1.api.riotgames.com"
    },
    oce: %{
      platform: "OC1",
      url: "https://oc1.api.riotgames.com"
    },
    tr: %{
      platform: "TR1",
      url: "https://tr1.api.riotgames.com"
    },
    ru: %{
      platform: "RU",
      url: "https://ru.api.riotgames.com"
    },
    pbe: %{
      platform: "PBE1",
      url: "https://pbe1.api.riotgames.com"
    }
  }

  @doc """
  Returns an atom, param can be a string or atom
  """

  def atomize(p) do
    if String.valid?(p) do
      String.to_atom(p)
    else
      p
    end
  end

  @doc """
  Returns true is the region is valid,
  region can be a string or an atom
  """

  def valid_region?(region) do
    Map.has_key?(@regions_and_platform_ids, atomize(region))
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
  Returns platform id based on the region,
  region can be a string or an atom
  """

  def get_platform_id(region) do
    Map.get(@regions_and_platform_ids, atomize(region))
    |> Map.get(:platform)
  end

  @doc """
  Returns the base url based on region,
  region can be a string or an atom
  """

  def base_url_region(region) do
    Map.get(@regions_and_platform_ids, atomize(region))
    |> Map.get(:url)
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
  Returns the api_key as a header for HTTPoison, set via environmental variable "RIOT_API_KEY"
  """

  def header_key() do
    ["X-Riot-Token": "#{System.get_env("RIOT_API_KEY")}"]
  end

  @doc """
  Executes HTTPoison.get with riot api key included via header
  """

  def httpoison_get_w_key(url) do
    HTTPoison.get!(url, header_key())
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

  def handle_response(%{status_code: 200, body: body}) do
    { :ok, Poison.Parser.parse!(body) }
  end

  def handle_response(%{status_code: _, body: body}) do
    { :error, Poison.Parser.parse!(body) }
  end

  # def handle_response({ :ok, %{status_code: 200, body: body}}) do
  #   { :ok, Poison.Parser.parse!(body) }
  # end
  #
  # def handle_response({ _,   %{status_code: _,   body: body}}) do
  #   { :error, Poison.Parser.parse!(body) }
  # end

end

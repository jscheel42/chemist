defmodule Chemist.Status do

  @api_version_status             1

  @moduledoc """
  Uses Status-v#{@api_version_status} API.
  """
    
  import Chemist.Util

  # Not used in any current urls, may be used in future
  # @api_version_status             Application.get_env(:chemist, :api_version_status)

  @doc """
  Contains shard status for all regions.
  
  Sample output:
      {:ok,
       [%{"hostname" => "prod.na1.lol.riotgames.com", "locales" => ["en_US"],
          "name" => "North America", "region_tag" => "na1", "slug" => "na"},
        %{"hostname" => "prod.euw1.lol.riotgames.com",
          "locales" => ["en_GB", "fr_FR", "it_IT", "es_ES", "de_DE"],
          "name" => "EU West", "region_tag" => "eu", "slug" => "euw"},
        %{"hostname" => "prod.eun1.lol.riotgames.com",
          "locales" => ["en_PL", "hu_HU", "pl_PL", "ro_RO", "cs_CZ", "el_GR"],
          "name" => "EU Nordic & East", "region_tag" => "eun1",
          "slug" => "eune"},
        %{"hostname" => "prod.la1.lol.riotgames.com", "locales" => ["es_MX"],
          "name" => "Latin America North", "region_tag" => "la1",
          "slug" => "lan"},
        %{"hostname" => "prod.la2.lol.riotgames.com", "locales" => ["es_AR"],
          "name" => "Latin America South", "region_tag" => "la2",
          "slug" => "las"},
        %{"hostname" => "prod.br.lol.riotgames.com", "locales" => ["pt_BR"],
          "name" => "Brazil", "region_tag" => "br1", "slug" => "br"},
        %{"hostname" => "prod.ru.lol.riotgames.com", "locales" => ["ru_RU"],
          "name" => "Russia", "region_tag" => "ru1", "slug" => "ru"},
        %{"hostname" => "prod.tr.lol.riotgames.com", "locales" => ["tr_TR"],
          "name" => "Turkey", "region_tag" => "tr1", "slug" => "tr"},
        %{"hostname" => "prod.oc1.lol.riotgames.com", "locales" => ["en_AU"],
          "name" => "Oceania", "region_tag" => "oc1", "slug" => "oce"},
        %{"hostname" => "prod.kr.lol.riotgames.com", "locales" => ["ko_KR"],
          "name" => "Republic of Korea", "region_tag" => "kr1",
          "slug" => "kr"},
        %{"hostname" => "prod.jp1.lol.riotgames.com", "locales" => ["ja_JP"],
          "name" => "Japan", "region_tag" => "jp1", "slug" => "jp"}]}
  """

  def shards(region) do
    region
    |> url_shards
    |> HTTPoison.get
    |> handle_response
  end

  @doc """
  Contains shard status for requested region.
  
  Sample output:
      {:ok,
       %{"hostname" => "prod.na1.lol.riotgames.com", "locales" => ["en_US"],
         "name" => "North America", "region_tag" => "na1",
         "services" => [%{"incidents" => [], "name" => "Game",
            "slug" => "game", "status" => "online"},
          %{"incidents" => [], "name" => "Store", "slug" => "store",
            "status" => "online"},
          %{"incidents" => [], "name" => "Website", "slug" => "website",
            "status" => "online"},
          %{"incidents" => [%{"active" => true,
               "created_at" => "2017-02-17T20:47:27.971Z", "id" => 3206,
               "updates" => [%{"author" => "",
                  "content" => "If you're having trouble updating to the League client beta please check out: http://riot.com/2llV9cD",
                  "created_at" => "2017-02-17T20:47:27.971Z",
                  "id" => "58a7615f2e6ef101005108f8", "severity" => "info",
                  "translations" => [],
                  "updated_at" => "2017-02-20T09:52:21.303Z"}]}],
            "name" => "Client", "slug" => "client", "status" => "online"},
          %{"incidents" => [], "name" => "League client update",
            "slug" => "league client update", "status" => "online"}],
         "slug" => "na"}}
  """

  def shard(region) do
    if valid_region?(region) do
      region
      |> url_shard
      |> HTTPoison.get
      |> handle_response
    else
      {:error, "invalid request"}
    end
  end
    
  defp url_shards(region) do
    base_url_region(region)
    <> "/lol/status/v#{@api_version_status}/shards?"
    <> url_key()
  end

  defp url_shard(region) do
    base_url_region(region)
    <> "/lol/status/v#{@api_version_status}/shard?"
    <> url_key()
  end

end

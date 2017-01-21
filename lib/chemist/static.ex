defmodule Chemist.Static do

  @moduledoc """
  Retrieve league data from Riot API
  and transform it into an Elixir friendly format
  """
    
  import Chemist.Util

  @api_version_lol_static_data             Application.get_env(:chemist, :api_version_lol_static_data)

  def champions(region, opts \\ %{}) do
    default_opts = %{locale: nil, version: nil, dataById: nil, champData: nil}

    if valid_region?(region) and valid_keys?(opts, default_opts) do
      region
      |> url_champions(opts, default_opts)
      |> HTTPoison.get
      |> handle_response
    else
      {:error, "invalid request"}
    end
  end

  def champion(region, id, opts \\ %{}) do
    default_opts = %{locale: nil, version: nil, champData: nil}
    
    if valid_region?(region) and valid_keys?(opts, default_opts) do
      region
      |> url_champion(id, opts, default_opts)
      |> HTTPoison.get
      |> handle_response
    else
      {:error, "invalid request"}
    end
  end

  def items(region, opts \\ %{}) do
    default_opts = %{locale: nil, version: nil, itemListData: nil}
    
    if valid_region?(region) and valid_keys?(opts, default_opts) do
      region
      |> url_items(opts, default_opts)
      |> HTTPoison.get
      |> handle_response
    else
      {:error, "invalid request"}
    end
  end

  def item(region, id, opts \\ %{}) do
    default_opts = %{locale: nil, version: nil, itemData: nil}
    
    if valid_region?(region) and valid_keys?(opts, default_opts) do
      region
      |> url_item(id, opts, default_opts)
      |> HTTPoison.get
      |> handle_response
    else
      {:error, "invalid request"}
    end
  end

  def language_strings(region, opts \\ %{}) do
    default_opts = %{locale: nil, version: nil}
    
    if valid_region?(region) and valid_keys?(opts, default_opts) do
      region
      |> url_language_strings(opts, default_opts)
      |> HTTPoison.get
      |> handle_response
    else
      {:error, "invalid request"}
    end
  end

  def languages(region) do
    if valid_region?(region) do
      region
      |> url_languages
      |> HTTPoison.get
      |> handle_response
    else
      {:error, "invalid request"}
    end
  end

  def map(region, opts \\ %{}) do
    default_opts = %{locale: nil, version: nil}
    
    if valid_region?(region) and valid_keys?(opts, default_opts) do
      region
      |> url_map(opts, default_opts)
      |> HTTPoison.get
      |> handle_response
    else
      {:error, "invalid request"}
    end
  end

  def masteries(region, opts \\ %{}) do
    default_opts = %{locale: nil, version: nil, masteryListData: nil}
    
    if valid_region?(region) and valid_keys?(opts, default_opts) do
      region
      |> url_masteries(opts, default_opts)
      |> HTTPoison.get
      |> handle_response
    else
      {:error, "invalid request"}
    end
  end

  def mastery(region, id, opts \\ %{}) do
    default_opts = %{locale: nil, version: nil, masteryListData: nil}
    
    if valid_region?(region) and valid_keys?(opts, default_opts) do
      region
      |> url_mastery(id, opts, default_opts)
      |> HTTPoison.get
      |> handle_response
    else
      {:error, "invalid request"}
    end
  end

  def realm(region) do
    if valid_region?(region) do
      region
      |> url_realm
      |> HTTPoison.get
      |> handle_response
    else
      {:error, "invalid request"}
    end
  end
  
  def runes(region, opts \\ %{}) do
    default_opts = %{locale: nil, version: nil, runeListData: nil}
    
    if valid_region?(region) and valid_keys?(opts, default_opts) do
      region
      |> url_runes(opts, default_opts)
      |> HTTPoison.get
      |> handle_response
    else
      {:error, "invalid request"}
    end
  end

  def rune(region, id, opts \\ %{}) do
    default_opts = %{locale: nil, version: nil, runeListData: nil}
    
    if valid_region?(region) and valid_keys?(opts, default_opts) do
      region
      |> url_rune(id, opts, default_opts)
      |> HTTPoison.get
      |> handle_response
    else
      {:error, "invalid request"}
    end
  end

  def summoner_spells(region, opts \\ %{}) do
    default_opts = %{locale: nil, version: nil, dataById: nil, spellData: nil}
    
    if valid_region?(region) and valid_keys?(opts, default_opts) do
      region
      |> url_summoner_spells(opts, default_opts)
      |> HTTPoison.get
      |> handle_response
    else
      {:error, "invalid request"}
    end
  end

  def summoner_spell(region, id, opts \\ %{}) do
    default_opts = %{locale: nil, version: nil, dataById: nil, spellData: nil}
    
    if valid_region?(region) and valid_keys?(opts, default_opts) do
      region
      |> url_summoner_spell(id, opts, default_opts)
      |> HTTPoison.get
      |> handle_response
    else
      {:error, "invalid request"}
    end
  end

  def versions(region) do
    if valid_region?(region) do
      region
      |> url_versions
      |> HTTPoison.get
      |> handle_response
    else
      {:error, "invalid request"}
    end
  end

  defp url_champions(region, opts, default_opts) do
    base_url_global()
    <> "/api/lol/static-data/#{region}/v#{@api_version_lol_static_data}/champion?"
    <> url_opts(opts, default_opts)
    <> url_key()
  end

  defp url_champion(region, id, opts, default_opts) do
    base_url_global()
    <> "/api/lol/static-data/#{region}/v#{@api_version_lol_static_data}/champion/#{id}?"
    <> url_opts(opts, default_opts)
    <> url_key()
  end

  defp url_items(region, opts, default_opts) do
    base_url_global()
    <> "/api/lol/static-data/#{region}/v#{@api_version_lol_static_data}/item?"
    <> url_opts(opts, default_opts)
    <> url_key()
  end

  defp url_item(region, id, opts, default_opts) do
    base_url_global()
    <> "/api/lol/static-data/#{region}/v#{@api_version_lol_static_data}/item/#{id}?"
    <> url_opts(opts, default_opts)
    <> url_key()
  end

  defp url_language_strings(region, opts, default_opts) do
    base_url_global()
    <> "/api/lol/static-data/#{region}/v#{@api_version_lol_static_data}/language-strings?"
    <> url_opts(opts, default_opts)
    <> url_key()
  end

  defp url_languages(region) do
    base_url_global()
    <> "/api/lol/static-data/#{region}/v#{@api_version_lol_static_data}/languages?"
    <> url_key()
  end

  defp url_map(region, opts, default_opts) do
    base_url_global()
    <> "/api/lol/static-data/#{region}/v#{@api_version_lol_static_data}/map?"
    <> url_opts(opts, default_opts)
    <> url_key()
  end

  defp url_masteries(region, opts, default_opts) do
    base_url_global()
    <> "/api/lol/static-data/#{region}/v#{@api_version_lol_static_data}/mastery?"
    <> url_opts(opts, default_opts)
    <> url_key()
  end

  defp url_mastery(region, id, opts, default_opts) do
    base_url_global()
    <> "/api/lol/static-data/#{region}/v#{@api_version_lol_static_data}/mastery/#{id}?"
    <> url_opts(opts, default_opts)
    <> url_key()
  end

  defp url_realm(region) do
    base_url_global()
    <> "/api/lol/static-data/#{region}/v#{@api_version_lol_static_data}/realm?"
    <> url_key()
  end
  
  defp url_runes(region, opts, default_opts) do
    base_url_global()
    <> "/api/lol/static-data/#{region}/v#{@api_version_lol_static_data}/rune?"
    <> url_opts(opts, default_opts)
    <> url_key()
  end
  
  defp url_rune(region, id, opts, default_opts) do
    base_url_global()
    <> "/api/lol/static-data/#{region}/v#{@api_version_lol_static_data}/rune/#{id}?"
    <> url_opts(opts, default_opts)
    <> url_key()
  end
  
  defp url_summoner_spells(region, opts, default_opts) do
    base_url_global()
    <> "/api/lol/static-data/#{region}/v#{@api_version_lol_static_data}/summoner-spell?"
    <> url_opts(opts, default_opts)
    <> url_key()
  end
  
  defp url_summoner_spell(region, id, opts, default_opts) do
    base_url_global()
    <> "/api/lol/static-data/#{region}/v#{@api_version_lol_static_data}/summoner-spell/#{id}?"
    <> url_opts(opts, default_opts)
    <> url_key()
  end
  
  defp url_versions(region) do
    base_url_global()
    <> "/api/lol/static-data/#{region}/v#{@api_version_lol_static_data}/versions?"
    <> url_key()
  end
end

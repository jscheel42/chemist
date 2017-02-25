defmodule Chemist.Static do

  @moduledoc """
  Retrieve league data from Riot API
  and transform it into an Elixir friendly format
  """
    
  import Chemist.Util

  @api_version_lol_static_data             Application.get_env(:chemist, :api_version_lol_static_data)

  @doc """
  Contains champion data for all champions.
  
  Default opts:
  * locale: default varies based on region
      * Locale code for returned data (e.g., en_US, es_ES).
  * version: latest version based on region
      * Data dragon version for returned data.
  * dataById: false
      * If specified as true, the returned data map will use the champions' IDs as the keys. If not specified or specified as false, the returned data map will use the champions' keys instead.
  * champData: Only type, version, data, id, key, name, and title are returned by default if this parameter isn't specified
      * Tags to return additional data.  To return all additional data, use the tag 'all'.
      * Possible values:
          * all
          * allytips
          * altimages
          * blurb
          * enemytips
          * image
          * info
          * lore
          * partype
          * passive
          * recommended
          * skins
          * spells
          * stats
          * tags

  Sample output:
      {:ok,
       %{"data" => %{"Ziggs" => %{"id" => 115, "key" => "Ziggs",
             "name" => "Ziggs", "title" => "the Hexplosives Expert"},
        ...
        },
       "type" => "champion", "version" => "7.4.3"}}
  """

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

  @doc """
  Contains champion data; retrieved by champion id.

  Default opts:
  * locale: default varies based on region
      * Locale code for returned data (e.g., en_US, es_ES).
  * version: latest version based on region
      * Data dragon version for returned data.
  * champData: Only type, version, data, id, key, name, and title are returned by default if this parameter isn't specified
      * Tags to return additional data.  To return all additional data, use the tag 'all'.
      * Possible values:
          * all
          * allytips
          * altimages
          * blurb
          * enemytips
          * image
          * info
          * lore
          * partype
          * passive
          * recommended
          * skins
          * spells
          * stats
          * tags

  Sample output:
      {:ok,
       %{"id" => 115, "key" => "Ziggs", "name" => "Ziggs",
         "title" => "the Hexplosives Expert"}}
  """

  def champion(region, champion_id, opts \\ %{}) do
    default_opts = %{locale: nil, version: nil, champData: nil}
    
    if valid_region?(region) and valid_keys?(opts, default_opts) do
      region
      |> url_champion(champion_id, opts, default_opts)
      |> HTTPoison.get
      |> handle_response
    else
      {:error, "invalid request"}
    end
  end

  @doc """
  Contains item data for all items.

  Default opts:
  * locale: default varies based on region
      * Locale code for returned data (e.g., en_US, es_ES).
  * version: latest version based on region
      * Data dragon version for returned data.
  * itemListData: Only type, version, basic, data, id, name, plaintext, group, and description are returned by default if this parameter isn't specified.
      * Tags to return additional data.  To return all additional data, use the tag 'all'.
      * Possible values:
          * all
          * colloq
          * consumeOnFull
          * consumed
          * depth
          * effect
          * from
          * gold
          * groups
          * hideFromAll
          * image
          * inStore
          * into
          * maps
          * requiredChampion
          * sanitizedDescription
          * specialRecipe
          * stacks
          * stats
          * tags
          * tree

  Sample output:
      {:ok,
       %{"basic" => %{"colloq" => "", "consumeOnFull" => false,
           "consumed" => false, "depth" => 1, "description" => "",
           "from" => [],
           "gold" => %{"base" => 0, "purchasable" => false, "sell" => 0,
             "total" => 0}, "group" => "", "hideFromAll" => false, "id" => 0,
           "image" => nil, "inStore" => true, "into" => [],
           "maps" => %{"1" => true, "10" => true, "12" => true, "8" => true},
           "name" => "", "plaintext" => "", "requiredChampion" => "",
           "rune" => %{"isRune" => false, "tier" => "1", "type" => "red"},
           "sanitizedDescription" => "", "specialRecipe" => 0, "stacks" => 1,
           "stats" => %{"FlatArmorMod" => 0.0, "PercentBlockMod" => 0.0,
             "rFlatMagicDamageModPerLevel" => 0.0, "PercentArmorMod" => 0.0,
             "rFlatSpellBlockModPerLevel" => 0.0,
             "rFlatEnergyModPerLevel" => 0.0, "FlatMPRegenMod" => 0.0,
             "rFlatArmorModPerLevel" => 0.0, "FlatAttackSpeedMod" => 0.0,
             "FlatBlockMod" => 0.0, "FlatHPRegenMod" => 0.0,
             "rFlatGoldPer10Mod" => 0.0, "rPercentTimeDeadMod" => 0.0,
             "PercentHPRegenMod" => 0.0,
             "rFlatMovementSpeedModPerLevel" => 0.0,
             "rFlatHPModPerLevel" => 0.0, "FlatEnergyRegenMod" => 0.0,
             "rFlatMPModPerLevel" => 0.0, "PercentSpellVampMod" => 0.0,
             "rFlatArmorPenetrationMod" => 0.0,
             "rPercentMovementSpeedModPerLevel" => 0.0, "rFlatDodgeMod" => 0.0, 
             "rFlatMPRegenModPerLevel" => 0.0,
             "rPercentMagicPenetrationModPerLevel" => 0.0,
             "PercentDodgeMod" => 0.0, "FlatCritChanceMod" => 0.0, ...},
           "tags" => []},
         "data" => %{"3124" => %{"description" => "<stats>+35 Attack Damage<br>+50 Ability Power<br>+25% Attack Speed</stats><br><br><passive>Passive: </passive>Basic attacks deal an additional 15 magic damage on hit.<br><unique>UNIQUE Passive:</unique> Basic attacks grant +8% Attack Speed, +3 Attack Damage, and +4 Ability Power for 5 seconds (stacks up to 6 times). While you have 6 stacks, gain <unlockedPassive>Guinsoo's Rage</unlockedPassive>.<br><br><unlockedPassive>Guinsoo's Rage:</unlockedPassive> Every other basic attack will trigger on hit effects an additional time.",
             "id" => 3124, "name" => "Guinsoo's Rageblade",
             "plaintext" => "Increases Ability Power and Attack Damage"},
           "2050" => %{"description" => "<consumable>Click to Consume:</consumable> Places an invisible ward that reveals the surrounding area for 60 seconds.",
             "id" => 2050, "name" => "Explorer's Ward"},
         ...
         },
       "type" => "item",
       "version" => "7.4.3"}}
  """

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

  @doc """
  Contains item data; retrieved by item id.
  
  Default opts:
  * locale: default varies based on region
      * Locale code for returned data (e.g., en_US, es_ES).
  * version: latest version based on region
      * Data dragon version for returned data.
  * itemData: Only type, version, basic, data, id, name, plaintext, group, and description are returned by default if this parameter isn't specified.
      * Tags to return additional data.  To return all additional data, use the tag 'all'.
      * Possible values:
          * all
          * colloq
          * consumeOnFull
          * consumed
          * depth
          * effect
          * from
          * gold
          * groups
          * hideFromAll
          * image
          * inStore
          * into
          * maps
          * requiredChampion
          * sanitizedDescription
          * specialRecipe
          * stacks
          * stats
          * tags
          * tree
  
  Sample output:
      {:ok,
       %{"description" => "<stats>+500 Health<br>+60 Armor<br>-10% Damage taken from Critical Strikes</stats><br><br><unique>UNIQUE Passive - Cold Steel:</unique> When hit by basic attacks, reduces the attacker's Attack Speed by 15% (1 second duration).<br><active>UNIQUE Active:</active> Slows the Movement Speed of nearby enemy units by 35% for 4 seconds (60 second cooldown).",
         "id" => 3143, "name" => "Randuin's Omen",
         "plaintext" => "Greatly increases defenses, activate to slow nearby enemies"}}
  """

  def item(region, item_id, opts \\ %{}) do
    default_opts = %{locale: nil, version: nil, itemData: nil}
    
    if valid_region?(region) and valid_keys?(opts, default_opts) do
      region
      |> url_item(item_id, opts, default_opts)
      |> HTTPoison.get
      |> handle_response
    else
      {:error, "invalid request"}
    end
  end

  @doc """
  Contains .
  
  Sample output:

  """

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

  @doc """
  Contains .
  
  Sample output:


  """

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

  @doc """
  Contains .
  
  Sample output:


  """

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

  @doc """
  Contains .
  
  Sample output:


  """

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

  @doc """
  Contains .
  
  Sample output:


  """

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

  @doc """
  Contains .
  
  Sample output:


  """

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

  @doc """
  Contains .
  
  Sample output:


  """

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

  @doc """
  Contains .
  
  Sample output:


  """

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

  @doc """
  Contains .
  
  Sample output:


  """

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

  @doc """
  Contains .
  
  Sample output:


  """

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

  @doc """
  Contains .
  
  Sample output:


  """

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

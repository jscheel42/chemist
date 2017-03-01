defmodule Chemist.Static do

  @api_version_lol_static_data             1.2

  @moduledoc """
  Use lol-static-v#{@api_version_lol_static_data} API.
  """
    
  import Chemist.Util

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
  Contains language string values.

  Default opts:
  * locale: default varies based on region
      * Locale code for returned data (e.g., en_US, es_ES).
  * version: latest version based on region
      * Data dragon version for returned data.
  
  Sample output:
      {:ok,
       %{"data" => %{"FlatArmorMod" => "Armor", "PercentBlockMod" => "Block %", 
           "PrimaryRole" => "Primary Role",
           "rFlatMagicDamageModPerLevel" => "Ability Power at level 18",
           "categoryMastery" => "Masteries", "colloq_Tenacity" => ";",
           "colloq_Boots" => ";", "Attack" => "Attack", "Active" => "Active",
           "Language" => "Language", "Map12" => "Howling Abyss",
           "spells_target_0" => "Self", "PercentArmorMod" => "Armor %",
           "Map10" => "The Twisted Treeline", "Slow" => "Slow",
           "Magic" => "Magic",
           "rFlatSpellBlockModPerLevel" => "Magic Resist at level 18",
           "native_ro" => "română", "spells_target_3" => "Cone",
           "Mage" => "Mage", "rFlatEnergyModPerLevel" => "Energy at level 18",
           "FlatMPRegenMod" => "Mana Regen / 5",
           "rFlatArmorModPerLevel" => "Armor at level 18",
           "SpecialRecipeLarge" => "Special", "Movement" => "Movement",
           "SpellVamp" => "Spell Vamp", "categoryChampion" => "Champions",
           "Aura" => "Aura", "FlatAttackSpeedMod" => "Attack Speed",
           "FlatBlockMod" => "Block",
           "MagicPenetration" => "Magic Penetration",
           "categoryRune" => "Runes", "SellsFor_" => "Sells for:",
           "Armor" => "Armor", "Rank_" => "Rank:", "colloq_Consumable" => ";",
           "FlatHPRegenMod" => "Health Regen / 5",
           "rFlatGoldPer10Mod" => "Gold per 10", "categoryItem" => "Items",
           "modeOneforall" => "FRONTEND_oneforall_game_mode_name",
           "rPercentTimeDeadMod" => "Time Dead %", "modeAram" => "ARAM",
           "colloq_Armor" => ";armour", "Tenacity" => "Tenacity",
           "PercentHPRegenMod" => "Health % / 5", "Require_" => "Requires:",
           "colloq_HealthRegen" => ";hpregen;hp5", "ManaRegen" => "Mana Regen", 
           ...}, "type" => "language", "version" => "7.4.3"}}
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
  Contains languages for the region.
  
  Sample output:
      {:ok,
       ["en_US", "cs_CZ", "de_DE", "el_GR", "en_AU", "en_GB", "en_PH", "en_PL", 
        "en_SG", "es_AR", "es_ES", "es_MX", "fr_FR", "hu_HU", "id_ID", "it_IT", 
        "ja_JP", "ko_KR", "ms_MY", "pl_PL", "pt_BR", "ro_RO", "ru_RU", "th_TH", 
        "tr_TR", "vn_VN", "zh_CN", "zh_MY", "zh_TW"]}
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
  Contains map data.

  Default opts:
  * locale: default varies based on region
      * Locale code for returned data (e.g., en_US, es_ES).
  * version: latest version based on region
      * Data dragon version for returned data.

  Sample output:
      {:ok,
       %{"data" => %{"10" => %{"image" => %{"full" => "map10.png",
               "group" => "map", "h" => 48, "sprite" => "map0.png", "w" => 48,
               "x" => 48, "y" => 0}, "mapId" => 10,
             "mapName" => "The Twisted Treeline"},
           "11" => %{"image" => %{"full" => "map11.png", "group" => "map",
               "h" => 48, "sprite" => "map0.png", "w" => 48, "x" => 96,
               "y" => 0}, "mapId" => 11, "mapName" => "Summoner's Rift"},
           "12" => %{"image" => %{"full" => "map12.png", "group" => "map",
               "h" => 48, "sprite" => "map0.png", "w" => 48, "x" => 144,
               "y" => 0}, "mapId" => 12, "mapName" => "Howling Abyss"},
           "14" => %{"image" => %{"full" => "map14.png", "group" => "map",
               "h" => 48, "sprite" => "map0.png", "w" => 48, "x" => 192,
               "y" => 0}, "mapId" => 14, "mapName" => "Butcher's Bridge"},
           "8" => %{"image" => %{"full" => "map8.png", "group" => "map",
               "h" => 48, "sprite" => "map0.png", "w" => 48, "x" => 0,
               "y" => 0}, "mapId" => 8, "mapName" => "The Crystal Scar"}},
         "type" => "map", "version" => "7.4.3"}}
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
  Contains mastery data for all masteries.

  Default opts:
  * locale: default varies based on region
      * Locale code for returned data (e.g., en_US, es_ES).
  * version: latest version based on region
      * Data dragon version for returned data.
  * masteryListData: Only type, version, data, id, name, and description are returned by default if this parameter isn't specified
      * Tags to return additional data. 
      * Possible values:
          * all
          * image
          * masteryTree
          * prereq
          * ranks
          * sanitizedDescription
          * tree

  Sample output:
      {:ok,
       %{"data" => %{"6343" => %{"description" => ["Champion kills and assists restore 5% of your missing Health and Mana"],
             "id" => 6343, "name" => "Dangerous Game"},
            ...
          }, 
          "type" => "mastery",
          "version" => "7.4.3"}}
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
  Contains mastery data for a mastery; retrieved by mastery id.
  
  Default opts:
  * locale: default varies based on region
      * Locale code for returned data (e.g., en_US, es_ES).
  * version: latest version based on region
      * Data dragon version for returned data.
  * masteryData: Only type, version, data, id, name, and description are returned by default if this parameter isn't specified
      * Tags to return additional data. 
      * Possible values:
          * all
          * image
          * masteryTree
          * prereq
          * ranks
          * sanitizedDescription

  Sample output:
      {:ok,
       %{"description" => ["+15 Movement Speed in Brush and River"],
         "id" => 6221, "name" => "Explorer"}}
  """

  def mastery(region, mastery_id, opts \\ %{}) do
    default_opts = %{locale: nil, version: nil, masteryData: nil}
    
    if valid_region?(region) and valid_keys?(opts, default_opts) do
      region
      |> url_mastery(mastery_id, opts, default_opts)
      |> HTTPoison.get
      |> handle_response
    else
      {:error, "invalid request"}
    end
  end

  @doc """
  Contains realm data.
  
  Sample output:
      {:ok,
       %{"cdn" => "http://ddragon.leagueoflegends.com/cdn", "css" => "7.4.3",
         "dd" => "7.4.3", "l" => "en_US", "lg" => "7.4.3",
         "n" => %{"champion" => "7.4.3", "item" => "7.4.3",
           "language" => "7.4.3", "map" => "7.4.3", "mastery" => "7.4.3",
           "profileicon" => "7.4.3", "rune" => "7.4.3", "summoner" => "7.4.3"}, 
         "profileiconmax" => 28, "v" => "7.4.3"}}
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
  Contains rune data for all runes.

  Default opts:
  * locale: default varies based on region
      * Locale code for returned data (e.g., en_US, es_ES).
  * version: latest version based on region
      * Data dragon version for returned data.
  * runeListData: Only type, version, data, id, name, rune, and description are returned by default if this parameter isn't specified.
      * Tags to return additional data.
      * Possible values:
          * all
          * basic
          * colloq
          * consumeOnFull
          * consumed
          * depth
          * from
          * gold
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

  Sample output:
      {:ok,
       %{"data" => %{"5300" => %{"description" => "+1.42 mana per level (+25.56 at champion level 18)",
             "id" => 5300, "name" => "Greater Glyph of Scaling Mana",
             "rune" => %{"isRune" => true, "tier" => "3", "type" => "blue"}},
        ...
        },
        "type" => "rune", "version" => "7.4.3"}}
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
  Contains rune data for requested rune; retrieved by rune id.

  Default opts:
  * locale: default varies based on region
      * Locale code for returned data (e.g., en_US, es_ES).
  * version: latest version based on region
      * Data dragon version for returned data.
  * runeData: Only type, version, data, id, name, rune, and description are returned by default if this parameter isn't specified.
      * Tags to return additional data.
      * Possible values:
          * all
          * basic
          * colloq
          * consumeOnFull
          * consumed
          * depth
          * from
          * gold
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

  Sample output:
      {:ok,
       %{"description" => "+1.04 magic resist", "id" => 5167,
         "name" => "Glyph of Magic Resist",
         "rune" => %{"isRune" => true, "tier" => "2", "type" => "blue"}}}
  """

  def rune(region, rune_id, opts \\ %{}) do
    default_opts = %{locale: nil, version: nil, runeData: nil}
    
    if valid_region?(region) and valid_keys?(opts, default_opts) do
      region
      |> url_rune(rune_id, opts, default_opts)
      |> HTTPoison.get
      |> handle_response
    else
      {:error, "invalid request"}
    end
  end

  @doc """
  Contains summoner spell data for all summoner spells.

  Default opts:
  * locale: default varies based on region
      * Locale code for returned data (e.g., en_US, es_ES).
  * version: latest version based on region
      * Data dragon version for returned data.
  * dataById: false
      * If specified as true, the returned data map will use the spells' IDs as the keys.
  * spellData: Only type, version, data, id, key, name, description, and summonerLevel are returned by default if this parameter isn't specified.
      * Tags to return additional data.
      * Possible values:
          * all
          * cooldown
          * cooldownBurn
          * cost
          * costBurn
          * costType
          * effect
          * effectBurn
          * image
          * key
          * leveltip
          * maxrank
          * modes
          * range
          * rangeBurn
          * resource
          * sanitizedDescription
          * sanitizedTooltip
          * tooltip
          * vars

  Sample output:
      {:ok,
       %{"data" => %{"SummonerBarrier" => %{"description" => "Shields your champion from 115-455 damage (depending on champion level) for 2 seconds.",
             "id" => 21, "key" => "SummonerBarrier", "name" => "Barrier",
             "summonerLevel" => 4},
          ...
          },
          "type" => "summoner",
          "version" => "7.4.3"}}
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
  Contains summoner spell data for requested summoner spell; retrieved by summoner spell id.

  Default opts:
  * locale: default varies based on region
      * Locale code for returned data (e.g., en_US, es_ES).
  * version: latest version based on region
      * Data dragon version for returned data.
  * spellData: Only type, version, data, id, key, name, description, and summonerLevel are returned by default if this parameter isn't specified.
      * Tags to return additional data.
      * Possible values:
          * all
          * cooldown
          * cooldownBurn
          * cost
          * costBurn
          * costType
          * effect
          * effectBurn
          * image
          * key
          * leveltip
          * maxrank
          * modes
          * range
          * rangeBurn
          * resource
          * sanitizedDescription
          * sanitizedTooltip
          * tooltip
          * vars

  Sample output:
      {:ok,
       %{"description" => "After channeling for 4.5 seconds, teleports your champion to target allied structure, minion, or ward.",
         "id" => 12, "key" => "SummonerTeleport", "name" => "Teleport",
         "summonerLevel" => 6}}
  """

  def summoner_spell(region, summoner_spell_id, opts \\ %{}) do
    default_opts = %{locale: nil, version: nil, dataById: nil, spellData: nil}
    
    if valid_region?(region) and valid_keys?(opts, default_opts) do
      region
      |> url_summoner_spell(summoner_spell_id, opts, default_opts)
      |> HTTPoison.get
      |> handle_response
    else
      {:error, "invalid request"}
    end
  end

  @doc """
  Contains version list.
  
  Sample output:
      {:ok,
       ["7.4.3", "7.4.2", "7.4.1", "7.3.3", "7.3.2", "7.3.1", "7.2.1", "7.1.1", 
        "6.24.1", "6.23.1", "6.22.1", "6.21.1", "6.20.1", "6.19.1", "6.18.1",
        "6.17.1", "6.16.2", "6.16.1", "6.15.1", "6.14.2", "6.14.1", "6.13.1",
        "6.12.1", "6.11.1", "6.10.1", "6.9.1", "6.8.1", "6.7.1", "6.6.1",
        "6.5.1", "6.4.2", "6.4.1", "6.3.1", "6.2.1", "6.1.1", "5.24.2",
        "5.24.1", "5.23.1", "5.22.3", "5.22.2", "5.22.1", "5.21.1", "5.20.1",
        "5.19.1", "5.18.1", "5.17.1", "5.16.1", "5.15.1", "5.14.1", ...]}
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

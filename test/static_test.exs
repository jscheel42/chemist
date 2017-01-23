defmodule StaticTest do
  use ExUnit.Case
  doctest Chemist

  import Chemist.Static
  import Chemist.Util
      
  test "Return champions" do
    region = "oce"
    
    { :ok, champions } = champions(region)
        
    ziggs =
      champions
      |> strip_key!
      |> Map.fetch!("Ziggs")
    
    assert Map.has_key?(ziggs, "name")
  end
  
  test "Return champion" do
    region = "oce"
    champion_id = 115
    
    { :ok, ziggs } = champion(region, champion_id)
    
    assert Map.has_key?(ziggs, "name")
  end
  
  test "Return items" do
    region = "oce"
    
    { :ok, items } = items(region)
    
    assert Map.has_key?(items, "data")
  end
  
  test "Return item" do
    region = "oce"

    { :ok, randuins_omen } = item(region, 3143)
    
    assert Map.has_key?(randuins_omen, "description")
  end
  
  test "Return language strings" do
    region = "oce"
    
    { :ok, language_strings } = language_strings(region)
    
    assert Map.has_key?(language_strings, "data")
  end
  
  test "Return languages" do
    region = "oce"
    
    { :ok, languages } = languages(region)
    
    assert Enum.any?(languages, &(&1 == "en_US"))
  end
  
  test "Return map" do
    region = "oce"
    
    { :ok, map } = map(region)
    
    assert Map.has_key?(map, "data")
  end
  
  test "Return masteries" do
    region = "oce"
    
    { :ok, masteries } = masteries(region)
    
    assert Map.has_key?(masteries, "data")
  end
  
  test "Return mastery" do
    region = "oce"
    
    { :ok, mastery } = mastery(region, 6121)
    
    assert Map.has_key?(mastery, "name")
  end
  
  test "Return realm" do
    region = "oce"
    
    { :ok, realm } = realm(region)
    
    assert Map.has_key?(realm, "css")
  end
  
  test "Return runes" do
    region = "oce"
    
    { :ok, runes } = runes(region)
    
    assert Map.has_key?(runes, "data")
  end
  
  test "Return rune" do
    region = "oce"
    
    { :ok, rune } = rune(region, 5413)
    
    assert Map.has_key?(rune, "name")
  end
  
  test "Return summoner spells" do
    region = "oce"
    
    { :ok, summoner_spells } = summoner_spells(region)
    
    assert Map.has_key?(summoner_spells, "data")
  end
  
  test "Return summoner spell" do
    region = "oce"
    
    { :ok, teleport } = summoner_spell(region, 12)
    
    assert Map.has_key?(teleport, "description")
  end
  
  test "Return versions" do
    region = "oce"
    
    { :ok, versions } = versions(region)
    
    assert Enum.any?(versions, &(&1 == "7.2.1"))
  end
end

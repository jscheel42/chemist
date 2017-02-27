defmodule Chemist.Summoner do

  @api_version_summoner    Application.get_env(:chemist, :api_version_summoner)

  @moduledoc """
  Uses v#{@api_version_summoner} API.
  """

  import Chemist.Util


  @doc """
  Contains summoner data; retrieved by summoner name.
  
  Sample output:
      {:ok,
       %{"jrizznezz" => %{"id" => 51666047, "name" => "jrizznezz",
           "profileIconId" => 1450, "revisionDate" => 1488042401000,
           "summonerLevel" => 30}}}
  """

  def summoner_by_name(region, summoner_name) do
    if String.match?(summoner_name, ~r/^[0-9\p{L} _\.]+$/) and valid_region?(region) do
      region
      |> url_summoner_by_name(remove_spaces(summoner_name))
      |> HTTPoison.get
      |> handle_response
    else
      {:error, "invalid request"}
    end
  end

  @doc """
  Contains summoner data; retrieved by summoner id.
  
  Sample output:
      {:ok,
       %{"51666047" => %{"id" => 51666047, "name" => "jrizznezz",
           "profileIconId" => 1450, "revisionDate" => 1488042401000,
           "summonerLevel" => 30}}}
  """

  def summoner_by_id(region, summoner_id) do
    if valid_region?(region) do
      region
      |> url_summoner_by_id(summoner_id)
      |> HTTPoison.get
      |> handle_response     
    else
      {:error, "invalid request"}
    end
  end

  @doc """
  Contains mastery data; retrieved by summoner id.
  
  Sample output:
      {:ok,
       %{"51666047" => %{"pages" => [%{"current" => false, "id" => 44027520,
              "masteries" => [%{"id" => 6121, "rank" => 1},
               %{"id" => 6343, "rank" => 1}, %{"id" => 6131, "rank" => 5},
               %{"id" => 6114, "rank" => 5}, %{"id" => 6331, "rank" => 5},
               %{"id" => 6141, "rank" => 1}, %{"id" => 6323, "rank" => 1},
               %{"id" => 6312, "rank" => 5}, %{"id" => 6351, "rank" => 5},
               %{"id" => 6362, "rank" => 1}], "name" => "AP/BURST"},
          ...
          ],
          "summonerId" => 51666047}}}
  """

  def masteries(region, summoner_id) do
    if valid_region?(region) do
      region
      |> url_masteries(summoner_id)
      |> HTTPoison.get
      |> handle_response      
    else
      {:error, "invalid request"}
    end
  end

  @doc """
  Contains summoner name; retrieved by summoner id.
  
  Sample output:
      {:ok, %{"51666047" => "jrizznezz"}}

  """

  def name(region, summoner_id) do
    if valid_region?(region) do
      region
      |> url_name(summoner_id)
      |> HTTPoison.get
      |> handle_response      
    else
      {:error, "invalid request"}
    end
  end

  @doc """
  Contains rune data; retrieved by summoner id.
  
  Sample output:
  {:ok,
   %{"51666047" => %{"pages" => [%{"current" => true, "id" => 69960969,
          "name" => "Blitzcrank",
          "slots" => [%{"runeId" => 5257, "runeSlotId" => 1},
           %{"runeId" => 5257, "runeSlotId" => 2},
           %{"runeId" => 5257, "runeSlotId" => 3},
           %{"runeId" => 5257, "runeSlotId" => 4},
           %{"runeId" => 5257, "runeSlotId" => 5},
           %{"runeId" => 5257, "runeSlotId" => 6},
           %{"runeId" => 5257, "runeSlotId" => 7},
           %{"runeId" => 5257, "runeSlotId" => 8},
           %{"runeId" => 5257, "runeSlotId" => 9},
           %{"runeId" => 5315, "runeSlotId" => 10},
           %{"runeId" => 5315, "runeSlotId" => 11},
           %{"runeId" => 5315, "runeSlotId" => 12},
           %{"runeId" => 5315, "runeSlotId" => 13},
           %{"runeId" => 5315, "runeSlotId" => 14},
           %{"runeId" => 5315, "runeSlotId" => 15},
           %{"runeId" => 5315, "runeSlotId" => 16},
           %{"runeId" => 5315, "runeSlotId" => 17},
           %{"runeId" => 5315, "runeSlotId" => 18},
           %{"runeId" => 5289, "runeSlotId" => 19},
           %{"runeId" => 5289, "runeSlotId" => 20},
           %{"runeId" => 5289, "runeSlotId" => 21},
           %{"runeId" => 5289, "runeSlotId" => 22},
           %{"runeId" => 5289, "runeSlotId" => 23},
           %{"runeId" => 5289, "runeSlotId" => 24},
           %{"runeId" => 5296, "runeSlotId" => 25},
           %{"runeId" => 5296, "runeSlotId" => 26},
           %{"runeId" => 5296, "runeSlotId" => 27},
           %{"runeId" => 5356, "runeSlotId" => 28},
           %{"runeId" => 5356, "runeSlotId" => 29},
           %{"runeId" => 5356, "runeSlotId" => 30}]},
      ...
      ],
      "summonerId" => 51666047}}}
  """

  def runes(region, summoner_id) do
    if valid_region?(region) do
      region
      |> url_runes(summoner_id)
      |> HTTPoison.get
      |> handle_response      
    else
      {:error, "invalid request"}
    end
  end

  @doc """
  Contains summoner id; retrieved by summoner name.
  
  Sample output:
      51666047

  """

  def id_by_name(region, name) do
    { :ok, summoner_data } = summoner_by_name(region, name)
    
    summoner_data
      |> strip_key!
      |> Map.fetch!("id")
  end

  defp remove_spaces(str), do: String.replace(str, " ", "")
  
  defp url_summoner_by_name(region, summoner) do
    base_url_region(region)
    <> "/api/lol/#{region}/v#{@api_version_summoner}/summoner/by-name/#{summoner}?"
    <> url_key()
  end

  defp url_summoner_by_id(region, id) do
    base_url_region(region)
    <> "/api/lol/#{region}/v#{@api_version_summoner}/summoner/#{id}?"
    <> url_key()
  end
  
  defp url_masteries(region, id) do
    base_url_region(region)
    <> "/api/lol/#{region}/v#{@api_version_summoner}/summoner/#{id}/masteries?"
    <> url_key()
  end
  
  defp url_name(region, id) do
    base_url_region(region)
    <> "/api/lol/#{region}/v#{@api_version_summoner}/summoner/#{id}/name?"
    <> url_key()
  end
  
  defp url_runes(region, id) do
    base_url_region(region)
    <> "/api/lol/#{region}/v#{@api_version_summoner}/summoner/#{id}/runes?"
    <> url_key()
  end
end

defmodule Chemist.ChampionMastery do

  @api_version_champion_mastery    3

  @moduledoc """
  Uses championmastery API.
  """

  import Chemist.Util

  @doc """
  Contains Champion Mastery information for a player's single champion; retrieved by player id and champion id.

  Sample output:
      {:ok,
       %{"championId" => 36, "championLevel" => 4, "championPoints" => 12917,
         "championPointsSinceLastLevel" => 317,
         "championPointsUntilNextLevel" => 8683, "chestGranted" => false,
         "lastPlayTime" => 1481350108000, "playerId" => 51666047,
         "tokensEarned" => 0}}
  """

  def champion(region, player_id, champion_id) do
    if valid_region?(region) do
      region
      |> url_champion(player_id, champion_id)
      |> httpoison_get_w_key
      |> handle_response
    else
      {:error, "invalid request"}
    end
  end

  @doc """
  Contains a list of Champion Mastery information for all a player's champions; retrieved by player id.

  Sample output:
      {:ok,
       [%{"championId" => 104, "championLevel" => 5,
          "championPoints" => 152302, "championPointsSinceLastLevel" => 130702,
          "championPointsUntilNextLevel" => 0, "chestGranted" => true,
          "lastPlayTime" => 1487921982000, "playerId" => 51666047,
          "tokensEarned" => 2}, ...
  """

  def champions(region, player_id) do
    if valid_region?(region) do
      region
      |> url_champions(player_id)
      |> httpoison_get_w_key
      |> handle_response
    else
      {:error, "invalid request"}
    end
  end

  @doc """
  Contains an integer with Champion Mastery score for a player; retrieved by player id.

  Sample output:
      {:ok, 195}
  """

  def score(region, player_id) do
    if valid_region?(region) do
      region
      |> url_score(player_id)
      |> httpoison_get_w_key
      |> handle_response
    else
      {:error, "invalid request"}
    end
  end

  # @doc """
  # Contains a list of Champion Mastery information for a player's top champions; retrieved by player id.
  #
  # Default opts:
  # * count: 3
  #     * Number of entries to retrieve
  #
  # Sample output (default options):
  #     {:ok,
  #      [%{"championId" => 104, "championLevel" => 5,
  #         "championPoints" => 152302, "championPointsSinceLastLevel" => 130702,
  #         "championPointsUntilNextLevel" => 0, "chestGranted" => true,
  #         "lastPlayTime" => 1487921982000, "playerId" => 51666047,
  #         "tokensEarned" => 2}, ...
  # """

  ## Cannot find equivalent api in v3, disabled for now
  # def top_champions(region, player_id, opts \\ %{}) do
  #   default_opts = %{count: nil}
  #
  #   if valid_region?(region) and valid_keys?(opts, default_opts) do
  #     region
  #     |> url_top_champions(player_id, opts, default_opts)
  #     |> httpoison_get_w_key
  #     |> handle_response
  #   else
  #     {:error, "invalid request"}
  #   end
  # end

  defp url_champion(region, player_id, champion_id) do
    base_url_region(region)
    <> "/lol/champion-mastery/v#{@api_version_champion_mastery}/champion-masteries/by-summoner/#{player_id}/by-champion/#{champion_id}?"
  end

  defp url_champions(region, player_id) do
    base_url_region(region)
    <> "/lol/champion-mastery/v#{@api_version_champion_mastery}/champion-masteries/by-summoner/#{player_id}?"
  end

  defp url_score(region, player_id) do
    base_url_region(region)
    <> "/lol/champion-mastery/v#{@api_version_champion_mastery}/scores/by-summoner/#{player_id}?"
  end

  # defp url_top_champions(region, player_id, opts, default_opts) do
  #   base_url_region(region)
  #   <> "/championmastery/location/#{get_platform_id(region)}/player/#{player_id}/topchampions?"
  #   <> url_opts(opts, default_opts)
  #   # <> url_key()
  # end

end

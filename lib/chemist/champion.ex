defmodule Chemist.Champion do

  @api_version_champion    1.2

  @moduledoc """
  Uses champion-v#{@api_version_champion} API.
  """

  import Chemist.Util
  
  @doc """
  Contains champion information for a single champion; retrieved by champion id.
  
  Sample output:
      {:ok,
       %{"active" => true, "botEnabled" => true, "botMmEnabled" => true,
         "freeToPlay" => false, "id" => 236, "rankedPlayEnabled" => true}}
  """
  
  def champion(region, champion_id) do
    if valid_region?(region) do
      region
      |> url_champion(champion_id)
      |> HTTPoison.get
      |> handle_response
    else
      {:error, "invalid request"}
    end
  end

  @doc """
  Contains a list of champion information for all champions.
  
  Default opts:
  * freeToPlay: false
      * Optional filter param to retrieve only free to play champions.
  
  Sample output:
      {:ok,
       %{"champions" => [%{"active" => true, "botEnabled" => false,
            "botMmEnabled" => false, "freeToPlay" => false, "id" => 266,
            "rankedPlayEnabled" => true}, ...
  """

  def champions(region, opts \\ %{}) do
    default_opts = %{freeToPlay: nil}

    if valid_region?(region) and valid_keys?(opts, default_opts) do
      region
      |> url_champions(opts, default_opts)
      |> HTTPoison.get
      |> handle_response
    else
      {:error, "invalid request"}
    end
  end

  defp url_champions(region, opts, default_opts) do
    base_url_region(region)
    <> "/api/lol/#{region}/v#{@api_version_champion}/champion?"
    <> url_opts(opts, default_opts)
    <> url_key()
  end
  
  defp url_champion(region, champion_id) do
    base_url_region(region)
    <> "/api/lol/#{region}/v#{@api_version_champion}/champion/#{champion_id}?"
    <> url_key()
  end

end

defmodule Chemist.Static do

  @moduledoc """
  Retrieve league data from Riot API
  and transform it into an Elixir friendly format
  """
    
  import Chemist.Util

  @api_version_lol_static_data             Application.get_env(:chemist, :api_version_lol_static_data)

  def champions(region, opts \\ %{}) do
    if valid_region?(region) do
      region
      |> url_champions(opts)
      |> HTTPoison.get
      |> handle_response
    else
      {:error, "invalid request"}
    end
  end
      
  defp url_champions(region, opts) do
    defaults = %{locale: nil, version: nil, dataById: nil, champData: nil}
    
    base_url_global
    <> "/api/lol/static-data/#{region}/v#{@api_version_lol_static_data}/champion?"
    <> url_opts(opts, defaults)
    <> url_key()
  end

end

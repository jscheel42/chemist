defmodule Chemist.Mixfile do
  use Mix.Project

  def project do
    [
      app: :chemist,
      version: "0.5.0",
      name: "Chemist",
      description: "Chemist is an Elixir wrapper for the Riot API.",
      source_url: "https://github.com/jscheel42/chemist",
      elixir: "~> 1.5",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps(),
      docs: docs(),
      package: package()
    ]
  end

  def application do
    [
      applications: [ :logger, :httpoison, :poison ]
    ]
  end

  defp deps do
    [
      { :ex_doc,      "~> 0.18.1", only: :dev },
      { :httpoison,   "~> 0.13"               },
      { :poison,      "~> 3.1"                }
    ]
  end

  defp docs do
    [
      main: "Chemist",
      extras: ["README.md"],
      output: ["docs"]
    ]
  end

  defp package do
    [
      licenses: ["MIT"],
      maintainers: ["Joshua Scheel"],
      links: %{"Github": "https://github.com/jscheel42/chemist",
               "TravisCI": "https://travis-ci.org/jscheel42/chemist"}
    ]
  end
end

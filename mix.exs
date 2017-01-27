defmodule Chemist.Mixfile do
  use Mix.Project

  def project do
    [
      app: :chemist,
      version: "0.1.0",
      name: "Chemist",
      source_url: "https://github.com/jscheel42/chemist",
      elixir: "~> 1.4",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps(),
      docs: [ main: "Chemist",
              extras: ["README.md"]]
    ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [ :logger, :httpoison ]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      { :httpoison, "~> 0.11"   },
      { :poison,    "~> 3.1"    },
      { :ex_doc,    "~> 0.14.5", only: :dev }
    ]
  end
end

#---
# Excerpted from "Programming Elixir 1.2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/elixir13 for more book information.
#---
defmodule Chemist.CLI do

  @moduledoc """
  Handle the command line parsing
  and dispatch to internal functions
  for processing
  """

  def run(argv) do
    argv
    |> parse_args
    |> process
  end

  @doc """
  `argv` can be -h or --help, which returns :help.

  Otherwise it is a summoner name.

  Return a tuple of `{ summoner, { id, name, profileIconId, summonerLevel, revisionDate } }`, or `:help` if help was given.
  """
  def parse_args(argv) do
    parse = OptionParser.parse(argv, switches: [ help: :boolean],
                                     aliases:  [ h:    :help   ])
    case  parse  do

    { [ help: true ], _, _ } 
      -> :help

    { _, [ summoner ], _ }  
      -> summoner

    _ -> :help

    end
  end
  
  def process(:help) do
    IO.puts """
    usage: chemist <summoner>
    """
    System.halt(0)
  end
  
  def process(summoner) do
    Chemist.Summoner.fetch(summoner)
    |> decode_response
  end
  
  def decode_response({ :ok, body }), do: body
  
  def decode_response({ :error, error }) do
    { _, message } = List.keyfind(error, "message", 0)
    IO.puts "Error fetching summoner: #{message}"
    System.halt(2)
  end
end

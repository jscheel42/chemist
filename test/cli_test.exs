defmodule CliTest do
  use ExUnit.Case
  doctest Chemist

  import Chemist.CLI, only: [ parse_args: 1 ]

  test ":help returned by option parsing with -h and --help options" do
    assert parse_args(["-h",     "anything"]) == :help
    assert parse_args(["--help", "anything"]) == :help
  end

  test "name returned if given" do
    assert parse_args(["singedplayer42"]) == "singedplayer42"
  end
end

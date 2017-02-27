[![Build Status](https://travis-ci.org/jscheel42/chemist.svg?branch=master)](https://travis-ci.org/jscheel42/chemist)

# Chemist

Chemist is an Elixir wrapper for the Riot API.

## Preparation

You will need a Riot Api Key, which you can get by signing up at the [Riot Games Developer] site.
Set the environmental variable "RIOT_API_KEY" to your key.

## Sample standalone startup script:
```
#!/bin/bash

export RIOT_API_KEY="myriotkey"

iex -S mix
```

## Installation

  1. Add `chemist` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:chemist, "~> 0.1.0"}]
    end
    ```

  2. Ensure `chemist` is started before your application:

    ```elixir
    def application do
      [applications: [:chemist]]
    end
    ```

## Other implementations for the Riot API in Elixir

[viktor]
[velkoz]

[Riot Games Developer]:https://developer.riotgames.com/
[viktor]:https://github.com/josephyi/viktor
[velkoz]:https://github.com/Tim-Machine/velkoz

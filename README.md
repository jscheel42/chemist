[![Build Status](https://travis-ci.org/jscheel42/chemist.svg?branch=master)](https://travis-ci.org/jscheel42/chemist)

# Chemist

To use this module, you must set the environmental variable "RIOT_API_KEY" to the key which Riot provides.

## Sample startup script:
```
#!/bin/bash

export RIOT_API_KEY="myriotkey"

iex -S mix
```

**TODO: Add description**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

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

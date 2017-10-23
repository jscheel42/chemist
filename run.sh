#!/bin/bash

# export ERL_AFLAGS="-kernel shell_history enabled"
source ./export_api_key.sh

iex --erl "-kernel shell_history enabled" -S mix

# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :chemist,
  api_version_champion:         1.2,
  api_version_current_game:     1.0,
  api_version_featured_games:   1.0,
  api_version_game:             1.3,
  api_version_league:           2.5,
  api_version_lol_static_data:  1.2,
  api_version_lol_status:       1.0,
  api_version_match:            2.2,
  api_version_matchlist:        2.2,
  api_version_stats:            1.3,
  api_version_summoner:         1.4,
  api_version_team:             2.4

# This configuration is loaded before any dependency and is restricted
# to this project. If another project depends on this project, this
# file won't be loaded nor affect the parent project. For this reason,
# if you want to provide default values for your application for
# 3rd-party users, it should be done in your "mix.exs" file.

# You can configure for your application as:
#
#     config :chemist, key: :value
#
# And access this configuration in your application as:
#
#     Application.get_env(:chemist, :key)
#
# Or configure a 3rd-party app:
#
#     config :logger, level: :info
#

# It is also possible to import configuration files, relative to this
# directory. For example, you can emulate configuration per environment
# by uncommenting the line below and defining dev.exs, test.exs and such.
# Configuration from the imported file will override the ones defined
# here (which is why it is important to import them last).
#
#     import_config "#{Mix.env}.exs"

# import_config "prod.secret.exs"

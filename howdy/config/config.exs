# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

# This configuration is loaded before any dependency and is restricted
# to this project. If another project depends on this project, this
# file won't be loaded nor affect the parent project. For this reason,
# if you want to provide default values for your application for
# 3rd-party users, it should be done in your "mix.exs" file.

# You can configure for your application as:
#
#     config :howdy, key: :value
#
# And access this configuration in your application as:
#
#     Application.get_env(:howdy, :key)
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

wobserver_port = case System.get_env("PORT") do
  nil  -> 4001
  port -> String.to_integer(port)
end

# wobserver_discovery_search = fn ->
#     [
#       %{
#         name: "one",
#         host: "127.0.0.1",
#         port: 4001,
#         local?: true,
#       },
#       %{
#         name: "two",
#         host: "127.0.0.1",
#         port: 4002,
#         local?: true,
#       },
#     ]
# end

config :wobserver,
  port: wobserver_port #,
  # discovery: :custom,
  # discovery_search: wobserver_discovery_search

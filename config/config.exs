import Config

config :spintria,
  ecto_repos: [Spintria.Repo]

config :tesla, adapter: Tesla.Adapter.Hackney

import_config("#{config_env()}.exs")

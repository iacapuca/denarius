import Config

config :denarius,
  ecto_repos: [Denarius.Repo]

config :tesla, adapter: Tesla.Adapter.Hackney

import_config("#{config_env()}.exs")

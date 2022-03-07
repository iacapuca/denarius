import Config

config :denarius, :exchange_api, Denarius.Exchange.Client

import_config("dev.secret.exs")

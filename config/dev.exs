import Config

config :denarius, :exchange_api, Denarius.Exchange.Client

config :denarius,
  exchangeratesapi_token: System.get_env("EXCHANGERATE_API_TOKEN")

config :denarius, Denarius.Repo,
  url: System.get_env("DATABASE_URL"),
  show_sensitive_data_on_connection_error: true,
  pool_size: 10

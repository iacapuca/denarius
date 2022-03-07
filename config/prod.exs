import Config

config :spintria, :exchange_api, Spintria.Exchange.Client

config :spintria, Spintria.Repo,
  adapter: Ecto.Adapter.Postgres,
  url: System.get_env("DATABASE_URL"),
  show_sensitive_data_on_connection_error: false,
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10"),
  ssl: true

config :spintria,
  exchangeratesapi_token: System.get_env("EXCHANGERATE_API_TOKEN")

config :logger, level: :info

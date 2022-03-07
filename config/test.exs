import Config

config :denarius, Denarius.Repo,
  database: System.get_env("POSTGRES_DATABASE") || "denarius_test",
  username: System.get_env("POSTGRES_USER") || "denarius",
  password: System.get_env("POSTGRES_PASSWORD") || "denarius",
  hostname: System.get_env("POSTGRES_HOST") || "localhost",
  show_sensitive_data_on_connection_error: true,
  pool: Ecto.Adapters.SQL.Sandbox

config :denarius, :exchange_api, Denarius.Exchange.MockClient

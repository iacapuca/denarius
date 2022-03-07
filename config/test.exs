import Config

config :spintria, Spintria.Repo,
  database: "spintria_test",
  username: "spintria",
  password: "spintria",
  hostname: "localhost",
  show_sensitive_data_on_connection_error: true,
  pool: Ecto.Adapters.SQL.Sandbox

config :spintria, :exchange_api, Spintria.Exchange.MockClient

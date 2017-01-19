use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :phoenix_game, PhoenixGame.Endpoint,
  http: [port: 4001],
  server: true

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :phoenix_game, PhoenixGame.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "phoenix_game_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

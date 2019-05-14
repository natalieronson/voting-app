# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

config :voting, Voting.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "voting_repo",
  username: "user",
  password: "pass",
  hostname: "localhost"


config :voting, Voting.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "voting_repo",
  username: "user",
  password: "pass",
  hostname: "localhost"


# General application configuration
config :voting,
  ecto_repos: [Voting.Repo]

# Configures the endpoint
config :voting, VotingWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "cwki3tE0i/EUur9t7GTZtlO0R3aEXdR8kaNd79Wqxf9zGyiAOjdOKzLXQcnf8yJn",
  render_errors: [view: VotingWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Voting.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

#Configures Guardian
config :voting, Voting.Guardian,
       issuer: "voting",
       secret_key: "ABC123"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

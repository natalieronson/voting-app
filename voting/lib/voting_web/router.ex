defmodule VotingWeb.Router do
  use VotingWeb, :router
  alias Voting.Guardian

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do

  end

  scope "/", VotingWeb do
    pipe_through ([:browser, :auth])

    get "/", PageController, :index
  end

  scope "/", VotingWeb do
    pipe_through :api

    post "/create-user", UserController, :save_user
    post "/login", UserController, :login
    get "/polls", PollController, :get_poll_list
    post "/create-poll", PollController, :create_poll
    post "/vote", VoteController, :add_vote
  end

  # Other scopes may use custom stacks.
  # scope "/api", VotingWeb do
  #   pipe_through :api
  # end
end

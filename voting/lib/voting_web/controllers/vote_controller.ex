defmodule VotingWeb.VoteController do
  use VotingWeb, :controller
  alias Plug.Conn
  alias Voting.Schemas.Answer
  import Ecto.Query
  alias Voting.Repo


  def add_vote(conn, %{"answerId" => answer_id, "pollId" => poll_id}) do
    query = from(a in Answer, update: [inc: [number_of_votes: 1]], where: a.id == ^answer_id)

  # TODO: fix bug where update changes the location in the database
    query |> Repo.update_all([])
    json conn, %{}
  end
end

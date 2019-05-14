defmodule VotingWeb.PollController do
  alias Voting.Schemas.Poll
  alias Voting.Schemas.Answer
  alias Voting.Repo
  alias VotingWeb.PollService
  alias VotingWeb.UserService
  import Ecto.Query
  import Ecto.Changeset
  use VotingWeb, :controller

  def save_poll(question, answers, user) do
    changeset = Poll.changeset(%Poll{}, %{question: question, user_id: user})
    {:ok, %{id: id}} = Repo.insert(changeset)

    answers
    |> Enum.each(fn x -> add_answer_to_poll(x, id) end)

  end

  def create_poll(conn, %{"poll" => %{ "options" => options, "question" => question}, "token" => token}) do
    user = UserService.get_user_from_token(token)
    save_poll(question, options, user)
    json conn, %{"hi": "hi"}
  end

  def get_current_vote(answer_id) do
    query = from(a in "answers",
    where: a.id == ^answer_id,
    select: a.number_of_votes)

    Repo.one(query)
  end

  def vote(answer_id) do
    incremented_vote = get_current_vote(answer_id) + 1
    from(a in Answer, where: a.id == ^answer_id, update: [set: [number_of_votes: ^incremented_vote]])
    |> Repo.update_all([])
  end

  def add_answer_to_poll(answer, poll_id) do
    changeset = Answer.changeset(%Answer{}, %{poll_id: poll_id, answer_text: answer, number_of_votes: 0})
    Repo.insert(changeset)
  end

  def get_poll_list(conn, _params) do
    polls = PollService.get_all_available_polls()
    json conn, %{polls: polls}
  end
end

defmodule VotingWeb.PollService do
 use VotingWeb, :controller
import Ecto.Query
alias Voting.Repo
alias Voting.Schemas.{Answer, Poll}
import Poison

  def get_all_available_polls() do

    Poll
    |> Repo.all
    |> Repo.preload([answers: (from a in Answer, order_by: a.id)])
    |> IO.inspect(label: :all_data)
    |> data_to_json()
    |> IO.inspect(label: :data_to_json)
    |> Poison.encode!()
  end

  def data_to_json(polls) do
    polls
    |> Enum.map(fn x -> Map.get_and_update(x, :answers, fn current_value ->
    {current_value, convert_answers(current_value)} end) end)
    |> Enum.map(fn {old_value, x} -> Map.take(x, [:answers, :id, :question, :user_id ]) end)
  end

  def convert_answers(list) do
    list
    |> Enum.map(fn x -> x |> Map.take([:answer_text, :number_of_votes, :id]) end)
  end
end

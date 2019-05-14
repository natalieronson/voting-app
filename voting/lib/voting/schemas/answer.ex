defmodule Voting.Schemas.Answer do
  use Ecto.Schema
  import Ecto.Changeset
  alias Voting.Schemas.Poll

  schema "answers" do
    belongs_to :poll, Poll
    field :answer_text, :string
    field :number_of_votes, :integer
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:poll_id, :answer_text, :number_of_votes])
    |> validate_required([:poll_id, :answer_text, :number_of_votes])
  end
end

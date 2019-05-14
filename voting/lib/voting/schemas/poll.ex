defmodule Voting.Schemas.Poll do
  use Ecto.Schema
  import Ecto.Changeset
  alias Voting.Schemas.Answer

  schema "polls" do
    field :question, :string
    field :user_id, :string

    has_many :answers, Answer
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:question, :user_id])
    |> validate_required([:question])
  end
end

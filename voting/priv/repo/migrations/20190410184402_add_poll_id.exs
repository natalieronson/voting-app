defmodule Voting.Repo.Migrations.AddPollId do
  use Ecto.Migration

  def change do
    alter table(:answers) do
      add :poll_id, :string
    end
  end
end

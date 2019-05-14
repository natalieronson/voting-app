defmodule Voting.Repo.Migrations.AddUserIdToPolls do
  use Ecto.Migration

  def change do
    alter table(:polls) do
      add :user_id, :string
    end
  end
end

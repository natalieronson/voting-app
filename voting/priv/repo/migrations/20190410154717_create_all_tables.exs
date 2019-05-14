defmodule Voting.Repo.Migrations.CreateAllTables do
  use Ecto.Migration

    def change do
      create table(:polls) do
        add :question, :string
      end
      create table(:users) do
        add :password_hash, :string
      end
      create table(:answers) do
        add :answer_text, :string
        add :number_of_votes, :int
      end
    end
end

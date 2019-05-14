defmodule Voting.Repo.Migrations.AlterTypePollId do
  use Ecto.Migration
  import Ecto.Query
  alias Voting.Repo

  def up do
    rename table(:answers), :poll_id, to: :poll_id_old
    alter table(:answers) do
      add :poll_id, references(:polls, on_delete: :delete_all)
    end
    flush()

    from(p in "answers", update: [
      set: [poll_id: fragment("?::bigint", p.poll_id_old)]
    ])
    |> Repo.update_all([])
  end
  def down do
    from(p in "answers", update: [
      set: [poll_id_old: fragment("?::varchar", p.poll_id)]
    ])
    |> Repo.update_all([])

    alter table(:answers) do
      remove :poll_id
    end
    rename table(:answers), :poll_id_old, to: :poll_id
  end
end

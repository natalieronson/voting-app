defmodule Voting.Schemas.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Comeonin.Bcrypt

  schema "users" do
    field :password, :string
    field :email, :string
    field :token, :string
  end

  def changeset(%__MODULE__{} = user, params \\ %{}) do
    user
    |> IO.inspect(label: :struct)
    |> cast(params, [:password, :email])
    |> unique_constraint(:email)
    |> validate_required([:password, :email])
    |> hash_password
  end

  def hash_password(%Ecto.Changeset{changes: %{password: password}} = changeset) do
    hashed_password = Comeonin.Bcrypt.hashpwsalt(password)
    changeset = put_change(changeset, :password, hashed_password)
  end
end

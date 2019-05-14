defmodule VotingWeb.UserController do
  use VotingWeb, :controller
  import Ecto.Query
  alias Voting.Schemas.User
  alias Voting.Repo
  alias Comeonin.Bcrypt
  alias Voting.Guardian
  alias Plug.Conn
  alias Voting.Guardian.Plug

  def save_user(conn, %{"email" => email, "password" => password}) do
    changeset = User.changeset(%User{}, %{email: email, password: password})
    Repo.insert!(changeset)
    json conn, %{success: true}
  end

  def does_email_exist?(email) do
    count = from(u in "users",
      where: u.email == ^email,
      select: count(u.id))
    |> Repo.one()
    |> Kernel.>(0)
  end

  def login(conn, %{"email" => email, "password" => password}) do
    IO.puts "login"
    case authenticate_user(email, password) do
        {:ok, token, claims} ->
          conn = Voting.Guardian.Plug.sign_in(conn, email)
          json conn, %{token: token}
        {:error, reason} ->
          json conn, %{error: reason}
    end
  end

  def authenticate_user(email, password) do
    case does_email_exist?(email) do
      false ->
        {:error, :user_does_not_exist}
      true ->
        query = from u in "users",
          where: u.email == ^email,
          select: u.password

          hashed_password = Repo.one(query)

          case Comeonin.Bcrypt.checkpw(password, hashed_password) do
          true ->
            {:ok, token, claims} = Guardian.encode_and_sign(email)
          _ ->
            {:error, :unauthorized}
      end
    end
  end
end

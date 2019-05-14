defmodule VotingWeb.UserService do
 alias Plug.Conn
 alias Voting.Guardian

  def get_token_from_conn(conn) do
    user =
    conn
    |> Conn.fetch_cookies
    |> Map.get("token")

    %{cookies: cookies} = user
    %{"token" => token} = cookies
    token

  end

  def get_user_from_token(token) do
    {:ok, %{"sub" => sub}} = Guardian.decode_and_verify(token)
    sub
  end

end

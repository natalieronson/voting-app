defmodule MyApp.Plug.Auth do
  import Plug.Conn

  def init(options), do: options

  def call(conn, _opts) do
    conn
    |> put_session(:user, %{name: "Jack"})
  end
end

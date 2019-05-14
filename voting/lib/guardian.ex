defmodule Voting.Guardian do
  use Guardian, otp_app: :voting
  import Ecto.Query
  alias Voting.Schemas.User
  import Ecto.Repo

  # this is all part of the Guardian plug

  # resource refers to the user
  # subject refers to the user's primary key or other unique identifier

  def subject_for_token(email, _claims) do
    {:ok, email}
  end
  def subject_for_token(_, _) do
    {:error, :reason_for_error}
  end

  def resource_from_claims(claims) do
    # Here we'll look up our resource from the claims, the subject can be
    # found in the `"sub"` key. In `above subject_for_token/2` we returned
    # the resource id so here we'll rely on that to look it up.
    email = claims["sub"]

    # This function should get the user by their unique id
    resource = Voting.get_resource_by_id(email)
    {:ok,  resource}
  end
  def resource_from_claims(_claims) do
    {:error, :reason_for_error}
  end

  def get_resource_by_id(email) do
    query = from u in User,
    where: u.email == ^email,
    select: u.id

    Repo.all(query)
  end
end

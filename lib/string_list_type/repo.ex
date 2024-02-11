defmodule StringListType.Repo do
  use Ecto.Repo,
    otp_app: :string_list_type,
    adapter: Ecto.Adapters.Postgres
end

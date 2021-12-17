defmodule Eiga.Repo do
  use Ecto.Repo,
    otp_app: :eiga,
    adapter: Ecto.Adapters.Postgres
end

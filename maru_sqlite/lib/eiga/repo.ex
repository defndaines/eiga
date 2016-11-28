defmodule Eiga.Repo do
  use Ecto.Repo, otp_app: :eiga, adapter: Sqlite.Ecto
end

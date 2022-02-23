defmodule IMDbData.Repo do
  use Ecto.Repo,
    otp_app: :imdb_data,
    adapter: Ecto.Adapters.SQLite3
end

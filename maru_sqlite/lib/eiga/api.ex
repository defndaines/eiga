defmodule Eiga.API do
  use Maru.Router

  @moduledoc """
  Defines the routes for this application.
  """
  # Adds parser which allows route to accept JSON POST.
  before do
    plug Plug.Parsers,
    pass: ["*/*"],
    json_decoder: Poison,
    parsers: [:urlencoded, :json, :multipart]
  end

  namespace :movies do
    desc "All movies."
    get do
      json(conn, Eiga.Store.all_movies())
    end
  end

  namespace :reviews do
    desc "All movie reviews."
    get do
      json(conn, Eiga.Store.all_reviews())
    end
  end

  def error(conn, e) do
    json(conn, %{error: e})
  end
end

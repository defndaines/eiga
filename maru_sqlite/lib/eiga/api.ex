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

    route_param :id do
      get do
        json(conn, Eiga.Store.get_movie(params[:id]))
      end
    end
  end

  namespace :reviews do
    desc "All movie reviews."
    params do
      optional :page, type: Integer
      optional :size, type: Integer, values: 10..100
    end
    get do
      page = if params[:page] do params[:page] else 1 end
      size = if params[:size] do params[:size] else 10 end
      json(conn, Eiga.Store.all_reviews(page, size))
    end
  end

  def error(conn, e) do
    json(conn, %{error: e})
  end
end

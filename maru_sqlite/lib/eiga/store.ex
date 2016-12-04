defmodule Eiga.Store do
  import Ecto.Query

  @moduledoc """
  Functions for interacting with the database.
  """
  
  alias Eiga.Repo
  alias Eiga.Movie
  alias Eiga.Review

  @doc "Get a list of all movies I have watched."
  def all_movies do
    Movie
    |> select([movie], movie)
    |> Repo.all
  end

  @doc "Get a list of all reviews."
  def all_reviews do
    query = from r in Review,
            join: m in Movie,
            order_by: r.view_date,
            select: %{movie: m.title, year: m.year, country: m.country,
                      location: r.location, view_date: r.view_date, review: r.text}
    Repo.all(query)
  end

  @doc """
  Insert a movie, but only if it doesn't exist in the database yet.
  Assumes that there is only one movie per year with a given name.
  """
  def insert_movie(%{"title" => title, "short_title" => short_title, "year" => year, "country" => country}) do
    case Repo.get_by(Movie, %{title: title, year: year}) do
      nil ->
        {:ok, new_movie} = Repo.insert(%Movie{title: title, short_title: short_title, year: year, country: country},
                                       on_conflict: :ignore, conflict_taget: [:title, :year])
        new_movie
      existing -> existing
    end
  end
end

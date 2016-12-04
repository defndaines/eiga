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
    date = String.to_integer(year)
    case Repo.get_by(Movie, %{title: title, year: date}) do
      nil ->
        {:ok, new_movie} = Repo.insert(%Movie{title: title, short_title: short_title, year: date, country: country},
                                       on_conflict: :ignore, conflict_taget: [:title, :year])
        new_movie
      existing -> existing
    end
  end

  @doc """
  Insert a movie review, but only if it doesn't exist in the database yet.
  Assumes that there is only one review per movie on a given date.
  """
  def insert_review(%{"location" => location, "short_title" => short_title, "text": text, "view_date": view_date}) do
    {:ok, date} = Ecto.Date.cast(view_date)
    # Movie must already be in the DB.
    movie = Repo.get_by!(Movie, short_title: short_title)
    Repo.insert(%Review{movie_id: movie.id, location: location, view_date: date, text: text},
                on_confict: :ignore, conflict_target: [:movie_id, :view_date])
  end
  def insert_review(got) do  ## FIXME: What is wrong with the function clause above?!?
    {:ok, date} = Ecto.Date.cast(got["view_date"])
    movie = Repo.get_by!(Movie, short_title: got["short_title"])
    Repo.insert(%Review{movie_id: movie.id, location: got["location"], view_date: date, text: got["text"]},
                on_confict: :ignore, conflict_target: [:movie_id, :view_date])
  end
end

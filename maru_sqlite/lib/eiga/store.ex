defmodule Eiga.Store do
  import Ecto.Query

  @moduledoc """
  Functions for interacting with the database.
  """

  alias Eiga.Repo
  alias Eiga.Movie
  alias Eiga.Review

  @doc "Get a list of all movies watched."
  def all_movies do
    Movie
    |> select([movie], %{id: movie.id, title: movie.title, year: movie.year, country: movie.country, short_title: movie.short_title})
    |> Repo.all
  end

  @doc "Get a single movie."
  def get_movie(id) do
    case Integer.parse(id) do
      {movie_id, ""} -> query_movie_by_id(movie_id)
      _ -> query_movie_by_short_title(id)
    end
  end

  defp query_movie_by_id(id) do
    query = from m in Movie,
            where: m.id == ^id,
            select: %{id: m.id, title: m.title, year: m.year, country: m.country}
    case Repo.all(query) do
      [movie] -> movie
      [] -> nil
    end
  end

  defp query_movie_by_short_title(short_title) do
    query = from m in Movie,
            where: m.short_title == ^short_title,
            select: %{id: m.id, title: m.title, year: m.year, country: m.country}
    case Repo.all(query) do
      [movie] -> movie
      [] -> nil
    end
  end

  @doc "Get a list of all reviews."
  def all_reviews(page \\ 1, size \\ 10) do
    query = from r in Review,
            join: m in Movie, where: r.movie_id == m.id,
            order_by: r.view_date,
            limit: ^size,
            offset: ^((page - 1) * size),
            select: %{movie: m.title, year: m.year, country: m.country,
              location: r.location, view_date: r.view_date, review: r.text}
    Repo.all(query)
  end

  @doc "Get a review."
  def get_review(id) do
    case Integer.parse(id) do
      {review_id, ""} -> query_review_by_id(review_id)
      _ -> query_review_by_short_title(id)
    end
  end

  defp query_review_by_id(id) do
    query = from r in Review,
            where: r.id == ^id,
            join: m in Movie, where: r.movie_id == m.id,
            select: %{movie: m.title, year: m.year, country: m.country,
              location: r.location, view_date: r.view_date, review: r.text}
    Repo.all(query)
  end

  defp query_review_by_short_title(short_title) do
    query = from r in Review,
            join: m in Movie, where: r.movie_id == m.id,
            where: m.short_title == ^short_title,
            select: %{movie: m.title, year: m.year, country: m.country,
              location: r.location, view_date: r.view_date, review: r.text}
    Repo.all(query)
  end

  @doc """
  Insert a movie.
  If it doesn't exist in the database yet, returns {:new, Movie}.
  If the movie already exists, returns {:existing, Movie} without changing.
  Assumes that there is only one movie per year with a given name.
  """
  def insert_movie(%{"title" => title, "short_title" => short_title, "year" => year, "country" => country}) do
    date = if is_integer(year) do year else String.to_integer(year) end
    case Repo.get_by(Movie, %{title: title, year: date}) do
      nil ->
        {:ok, new_movie} = Repo.insert(%Movie{title: title, short_title: short_title, year: date, country: country},
                                       on_conflict: :ignore, conflict_taget: [:title, :year])
        {:new, new_movie}
      existing -> {:existing, existing}
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
    case Repo.get_by(Review, %{movie_id: movie.id, view_date: date}) do
      nil ->
        {:ok, new_review} = Repo.insert(%Review{movie_id: movie.id, location: location, view_date: date, text: text},
                                        on_confict: :ignore, conflict_target: [:movie_id, :view_date])
        new_review
      existing -> existing
    end
  end
  def insert_review(got) do  ## FIXME: What is wrong with the function clause above?!? This gets called by data_import
    {:ok, date} = Ecto.Date.cast(got["view_date"])
    movie = Repo.get_by!(Movie, short_title: got["short_title"])
    case Repo.get_by(Review, %{movie_id: movie.id, view_date: date}) do
      nil ->
        {:ok, new_review} = Repo.insert(%Review{movie_id: movie.id, location: got["location"], view_date: date, text: got["text"]})
        new_review
      existing -> existing
    end
  end
end

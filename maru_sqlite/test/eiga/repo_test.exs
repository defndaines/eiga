defmodule Eiga.RepoTest do
  use ExUnit.Case

  alias Eiga.Repo
  alias Eiga.Movie
  alias Eiga.Review

  import Ecto.Query

  setup_all do
    pid = case Eiga.start(nil, nil) do
      {:ok, pid} -> pid
      {error, {:already_started, pid}} -> pid
    end
    {:ok, [pid: pid]}
  end

  test "data models are wired up correctly" do
    # Insert a new movie
    {:ok, movie} = Repo.insert(%Movie{title: "The Goonies", short_title: "goonies", year: 1985, country: "U.S."})
    movie_list = Movie |> select([movie], movie.title) |> Repo.all
    assert Enum.find(movie_list, &(&1 == "The Goonies"))

    # Insert a new review
    {:ok, review_time} = Ecto.Date.cast("2016-11-27")
    {:ok, review} = Repo.insert(%Review{movie_id: movie.id, location: "Blu-ray at home", view_date: review_time,
                                  text: "The Goonies 'R' Good Enough"})
    assert ["Blu-ray at home"] == Review
                                |> select([review], review.location)
                                |> where([review], review.movie_id == ^movie.id)
                                |> Repo.all

    # Load all reviews for a movie
    query = from m in Movie, where: m.id == ^movie.id, preload: [:review]
    reviews = query
              |> Repo.all
              |> Enum.map(fn(movie) -> movie.review end)
              |> List.flatten
              |> Enum.map(fn(review) -> review.text end)
    assert ["The Goonies 'R' Good Enough"] == reviews

    Repo.delete(review)
    Repo.delete(movie)
  end
end

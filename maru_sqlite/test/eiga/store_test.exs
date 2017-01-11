defmodule Eiga.StoreTest do
  use ExUnit.Case

  alias Eiga.Store

  import Ecto.Query

  setup_all do
    pid = case Eiga.start(nil, nil) do
      {:ok, pid} -> pid
      {:error, {:already_started, pid}} -> pid
    end
    {:ok, [pid: pid]}
  end

  test "inserting movies is idempotent" do
    movie_map = %{"title" => "The Goonies",
      "short_title" => "goonies",
      "year" => "1985",
      "country" => "U.S."}
    {_, movie} = Store.insert_movie(movie_map)

    movie_list = Eiga.Movie |> select([movie], movie.title) |> Eiga.Repo.all
    assert Enum.find(movie_list, &(&1 == movie_map["title"]))

    assert {:existing, movie} == Store.insert_movie(movie_map)
    assert Enum.filter(movie_list, &(&1 == movie_map["title"])) == [Enum.find(movie_list, &(&1 == movie_map["title"]))]

    Eiga.Repo.delete(movie)
  end

  test "inserting reviews is idempotent" do
    movie_map = %{"title" => "The Goonies",
      "short_title" => "the-goonies",
      "year" => "1985",
      "country" => "U.S."}
    {_, movie} = Store.insert_movie(movie_map)

    review_map = %{"location" => "Blu Ray at Home",
      "short_title" => "the-goonies",
      "text": "The Goonies 'R' Good Enough",
      "view_date": "2016-12-08"}

    review = Store.insert_review(review_map)

    assert review.id > 0

    assert review == Store.insert_review(review_map)

    Eiga.Repo.delete(review)
    Eiga.Repo.delete(movie)
  end

  test "get movie by ID" do
    movie_map = %{"title" => "The Goonies",
      "short_title" => "goonies",
      "year" => "1985",
      "country" => "U.S."}
    {_, movie} = Store.insert_movie(movie_map)

    found = Store.get_movie(Integer.to_string(movie.id))
    assert found.country == "U.S."
    assert found.title == "The Goonies"
    assert found.year == 1985

    Eiga.Repo.delete(movie)
  end

  test "get movie by short title" do
    movie_map = %{"title" => "The Goonies",
      "short_title" => "goonies",
      "year" => "1985",
      "country" => "U.S."}
    {_, movie} = Store.insert_movie(movie_map)

    found = Store.get_movie("goonies")
    assert found.country == "U.S."
    assert found.title == "The Goonies"
    assert found.year == 1985

    Eiga.Repo.delete(movie)
  end

  test "get unknown movie" do
    nil = Store.get_movie("mxyzptlk")
  end
end

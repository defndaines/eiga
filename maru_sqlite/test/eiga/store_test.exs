defmodule Eiga.StoreTest do
  use ExUnit.Case

  alias Eiga.Store

  import Ecto.Query

  setup_all do
    pid = case Eiga.start(nil, nil) do
      {:ok, pid} -> pid
      {error, {:already_started, pid}} -> pid
    end
    {:ok, [pid: pid]}
  end

  test "inserting movies is idempotent" do
    movie_map = %{"title" => "The Goonies",
     "short_title" => "goonies",
     "year" => 1985,
     "country" => "U.S."}

    movie = Store.insert_movie(movie_map)

    movie_list = Eiga.Movie |> select([movie], movie.title) |> Eiga.Repo.all
    assert Enum.find(movie_list, &(&1 == movie_map["title"]))

    movie = Store.insert_movie(movie_map)
    assert Enum.filter(movie_list, &(&1 == movie_map["title"])) == [Enum.find(movie_list, &(&1 == movie_map["title"]))]

    Eiga.Repo.delete(movie)
  end
end

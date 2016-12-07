defmodule Eiga.DataImportTest do
  use ExUnit.Case

  import Ecto.Query

  test "loads data files into SQLite database" do
    movie_dat = "../sql/movie.dat"

    File.stream!(movie_dat)
    |> Stream.map(&line_to_movie/1)
    |> Enum.each(&Eiga.Store.insert_movie(&1))

    iron_monkey = Eiga.Repo.get_by(Eiga.Movie, title: "Iron Monkey")
    assert iron_monkey.short_title == "ironmonkey"

    review_dat = "../sql/review.dat"

    File.stream!(review_dat)
    |> Stream.map(&line_to_review/1)
    |> Enum.each(&Eiga.Store.insert_review(&1))

    monkey_reviews = Eiga.Review
                     |> select([review], review.view_date)
                     |> where([review], review.movie_id == ^iron_monkey.id)
                     |> Eiga.Repo.all
    # assert ["2001-01-15", "2001-08-17"] == monkey_reviews
    assert 2 == length(monkey_reviews)
  end

  defp line_to_movie(line) do
    ["short_title", "title", "year", "country"]
    |> Enum.zip(String.split(line, "|"))
    |> Map.new
  end

  defp line_to_review(line) do
    ["id", "short_title", "location", "view_date", "text"]
    |> Enum.zip(String.split(line, "|"))
    |> Map.new
  end
end

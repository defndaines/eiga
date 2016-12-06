defmodule Eiga.DataImportTest do
  use ExUnit.Case

  import Ecto.Query

  test "loads CSV files into SQLite database" do
    movie_dat = "../sql/movie.dat"

    File.stream!(movie_dat)
    |> CSV.decode(headers: true, separator: ?|)
    |> Enum.each(&Eiga.Store.insert_movie(&1))

    iron_monkey = Eiga.Repo.get_by(Eiga.Movie, title: "Iron Monkey")
    assert iron_monkey.short_title == "ironmonkey"

    review_dat = "../sql/review.dat"

    File.stream!(review_dat)
    |> CSV.decode(headers: true, separator: ?|)
    |> Enum.each(&Eiga.Store.insert_review(&1))

    monkey_reviews = Eiga.Review
                     |> select([review], review.view_date)
                     |> where([review], review.movie_id == ^iron_monkey.id)
                     |> Eiga.Repo.all
    # assert ["2001-01-15", "2001-08-17"] == monkey_reviews
    assert 2 == length(monkey_reviews)
  end
end

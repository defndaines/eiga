defmodule Eiga.DataImportTest do
  use ExUnit.Case

  test "loads CSV files into SQLite database" do
    movie_csv = "../sql/movie.csv"

    File.stream!(movie_csv)
    |> CSV.decode(headers: true)
    |> Enum.each(&Eiga.Store.insert_movie(&1))
  end
end

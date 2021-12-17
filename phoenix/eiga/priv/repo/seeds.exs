# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Eiga.Repo.insert!(%Eiga.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

File.stream!("../../sql/movie.dat")
|> Enum.each(fn line ->
  [short_title, title, year, country] = line |> String.trim() |> String.split("|")

  %Eiga.Schema.Movie{
    short_title: short_title,
    title: title,
    year: String.to_integer(year),
    country: country
  }
  |> Eiga.Repo.insert!(on_conflict: :nothing)
end)

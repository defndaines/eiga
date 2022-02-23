# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     IMDbData.Repo.insert!(%IMDbData.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

keep_types = ~w(movie short tvMiniSeries tvMovie tvSeries)

File.stream!("priv/datasets/title.basics.tsv")
|> Enum.each(fn line ->
  [tconst, type, primary, original, adult, start_year, end_year, runtime, genres] =
    line |> String.trim() |> String.split("\t")

  # skip the header
  if type in keep_types do
    %IMDbData.Movies.Title{
      tconst: tconst,
      type: type,
      primary_title: primary,
      original_title: original,
      adult: adult == "1",
      start_year: if(start_year == "\\N", do: nil, else: String.to_integer(start_year)),
      end_year: if(end_year == "\\N", do: nil, else: String.to_integer(end_year)),
      runtime: if(runtime == "\\N", do: nil, else: String.to_integer(runtime)),
      genres: if(genres == "\\N", do: nil, else: genres)
    }
    |> IMDbData.Repo.insert!(on_conflict: :nothing)
  end
end)

File.stream!("priv/datasets/title.akas.tsv")
|> Enum.each(fn line ->
  [tconst, _ordering, title, region, language, types, attributes, _is_original] =
    line |> String.trim() |> String.split("\t")

  try do
    %IMDbData.Movies.Alias{
      tconst: tconst,
      title: title,
      region: if(region == "\\N", do: nil, else: region),
      language: if(language == "\\N", do: nil, else: language),
      types: if(types == "\\N", do: nil, else: types),
      attributes: if(attributes == "\\N", do: nil, else: attributes)
    }
    |> IMDbData.Repo.insert!(on_conflict: :nothing)
  rescue
    Ecto.ConstraintError -> "title \"#{tconst}\" does not exist"
  end
end)

File.stream!("priv/datasets/title.ratings.tsv")
|> Enum.each(fn line ->
  [tconst, rating, votes] = line |> String.trim() |> String.split("\t")

  try do
    %IMDbData.Movies.Review{
      tconst: tconst,
      rating: String.to_float(rating),
      votes: String.to_integer(votes)
    }
    |> IMDbData.Repo.insert!(on_conflict: :nothing)
  rescue
    Ecto.ConstraintError -> "title \"#{tconst}\" does not exist"
  end
end)

File.stream!("priv/datasets/name.basics.tsv")
|> Enum.each(fn line ->
  [nconst, name, birth, death, profs, _known_for] = line |> String.trim() |> String.split("\t")

  unless nconst == "nconst" do
    %IMDbData.People.Person{
      nconst: nconst,
      birth_year: if(birth == "\\N", do: nil, else: String.to_integer(birth)),
      death_year: if(death == "\\N", do: nil, else: String.to_integer(death)),
      name: name,
      professions: profs
    }
    |> IMDbData.Repo.insert!(on_conflict: :nothing)
  end
end)

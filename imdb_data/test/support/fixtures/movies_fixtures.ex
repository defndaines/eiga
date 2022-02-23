defmodule IMDbData.MoviesFixtures do
  @moduledoc """
  This module defines test helpers for creating entities via the `IMDbData.Movies` context.
  """

  @doc """
  Generate a title.
  """
  def title_fixture(attrs \\ %{}) do
    {:ok, title} =
      attrs
      |> Enum.into(%{
        adult: false,
        end_year: nil,
        genres: "Drama",
        original_title: "some original_title",
        primary_title: "some primary_title",
        runtime: 139,
        start_year: 1999,
        tconst: "tt9999999",
        type: "movie"
      })
      |> IMDbData.Movies.create_title()

    title
  end

  @doc """
  Generate a alias.
  """
  def alias_fixture(attrs \\ %{}) do
    {:ok, alias} =
      attrs
      |> Enum.into(%{
        attributes: nil,
        language: nil,
        region: nil,
        tconst: "tt9999999",
        title: "some title",
        types: "original"
      })
      |> IMDbData.Movies.create_alias()

    alias
  end

  @doc """
  Generate a review.
  """
  def review_fixture(attrs \\ %{}) do
    {:ok, review} =
      attrs
      |> Enum.into(%{
        rating: 0.5,
        tconst: "tt9999999",
        votes: 42
      })
      |> IMDbData.Movies.create_review()

    review
  end
end

defmodule Eiga.Movies do
  @moduledoc """
  Movie context.
  """

  import Ecto.Query, warn: false

  alias Eiga.Repo
  alias Eiga.Schema.Movie
  alias Eiga.Schema.Review

  @doc """
  Returns the list of all movies.
  """
  def list_movies, do: Repo.all(Movie)

  @doc """
  Returns the list of all reviews.
  """
  def list_reviews, do: Repo.all(Review)

  def list_reviews(%{short_title: short_title}) do
    Repo.all(from Review, where: [short_title: ^short_title])
  end

  def list_reviews(_args), do: list_reviews()

  def get_movie!(id), do: Repo.get!(Movie, id)

  def get_movie_by_short_title(short_title), do: Repo.get_by(Movie, short_title: short_title)

  def get_review_by_short_title_and_view_date(short_title, view_date) do
    Repo.get_by(Review, short_title: short_title, view_date: view_date)
  end
end

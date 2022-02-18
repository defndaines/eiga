defmodule EigaWeb.Resolver.Movies do
  @moduledoc """
  Absinthe GraphQL resolver for pulling information from the models.
  """

  alias Eiga.Movies

  def all_movies(_parent, _args, _resolution) do
    {:ok, Movies.list_movies()}
  end

  def all_reviews(%Eiga.Schema.Movie{} = movie, _args, _resolution) do
    {:ok, Movies.list_reviews(movie)}
  end

  def all_reviews(_parent, args, _resolution) do
    {:ok, Movies.list_reviews(args)}
  end

  def find_movie(%Eiga.Schema.Review{short_title: short_title}, _args, _resolution) do
    case Movies.get_movie_by_short_title(short_title) do
      nil -> {:error, "movie for #{short_title} not found"}
      movie -> {:ok, movie}
    end
  end

  def find_movie(_parent, %{short_title: short_title}, _resolution) do
    case Movies.get_movie_by_short_title(short_title) do
      nil -> {:error, "movie for #{short_title} not found"}
      movie -> {:ok, movie}
    end
  end

  def find_review(%Eiga.Schema.Movie{} = movie, _args, _resolution) do
    {:ok, Movies.list_reviews(movie)}
  end

  def find_review(_parent, %{short_title: short_title, view_date: view_date}, _resolution) do
    case Movies.get_review_by_short_title_and_view_date(short_title, view_date) do
      nil -> {:error, "review for #{short_title} not found"}
      review -> {:ok, review}
    end
  end
end

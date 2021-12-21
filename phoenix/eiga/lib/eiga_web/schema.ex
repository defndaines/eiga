defmodule EigaWeb.Schema do
  @moduledoc """
  Absinthe GraphQL schema.
  """

  use Absinthe.Schema

  alias EigaWeb.Resolver.Movies

  object :movie do
    field :movie_id, non_null(:id)
    field :short_title, non_null(:string)
    field :title, non_null(:string)
    field :year, non_null(:integer)
    field :country, non_null(:string)
    field :reviews, list_of(:review) do
      resolve(&Movies.all_reviews/3)
    end
  end

  object :review do
    field :review_id, non_null(:id)
    field :short_title, non_null(:string)
    field :location, non_null(:string)
    # TODO: Date as string for now. Adjust later?
    field :view_date, non_null(:string)
    field :text, non_null(:string)
    field :movie, :movie do
      resolve(&Movies.find_movie/3)
    end
  end

  query do
    @desc "Get all movies"
    field :all_movies, non_null(list_of(non_null(:movie))) do
      resolve(&Movies.all_movies/3)
    end

    field :movie, :movie do
      arg(:short_title, non_null(:string))
      resolve(&Movies.find_movie/3)
    end

    @desc "Get all reviews"
    field :reviews, list_of(:review) do
      arg(:short_title, :string)
      resolve(&Movies.all_reviews/3)
    end

    field :review, :review do
      arg(:short_title, non_null(:string))
      arg(:view_date, non_null(:string))
      resolve(&Movies.find_review/3)
    end
  end
end

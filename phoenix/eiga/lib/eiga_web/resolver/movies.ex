defmodule EigaWeb.Resolver.Movies do
  @moduledoc """
  Absinthe GraphQL resolver for pulling information from the models.
  """

  alias Eiga.Movies

  def all_movies(_parent, _args, _resolution) do
    {:ok, Movies.list_movies()}
  end
end

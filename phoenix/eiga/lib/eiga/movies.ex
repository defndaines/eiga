defmodule Eiga.Movies do
  @moduledoc """
  Movie context.
  """

  import Ecto.Query, warn: false

  alias Eiga.Repo
  alias Eiga.Schema.Movie
  alias Eiga.Schema.Review

  def get_movie!(id), do: Repo.get!(Movie, id)

  def get_movie_by_short_title!(short_title), do: Repo.get_by!(Movie, short_title: short_title)
end

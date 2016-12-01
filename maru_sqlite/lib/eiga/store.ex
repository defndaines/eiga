defmodule Eiga.Store do
  @moduledoc """
  Functions for interacting with the database.
  """
  
  alias Eiga.Repo
  alias Eiga.Movie
  alias Eiga.Review

  @doc """
  Insert a movie, but only if it doesn't exist in the database yet.
  Assumes that there is only one movie per year with a given name.
  """
  def insert_movie(%{"title" => title, "short_title" => short_title, "year" => year, "country" => country}) do
    case Repo.get_by(Movie, %{title: title, year: year}) do
      nil ->
        {:ok, new_movie} = Repo.insert(%Movie{title: title, short_title: short_title, year: year, country: country},
                                       on_conflict: :ignore, conflict_taget: [:title, :year])
        new_movie
      existing -> existing
    end
  end
end

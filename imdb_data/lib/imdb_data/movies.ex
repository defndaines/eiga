defmodule IMDbData.Movies do
  @moduledoc """
  The Movies context.
  """

  import Ecto.Query, warn: false
  alias IMDbData.Repo

  alias IMDbData.Movies.Title

  @doc """
  Returns the list of titles.

  ## Examples

      iex> list_titles()
      [%Title{}, ...]

  """
  def list_titles do
    Repo.all(Title)
  end

  @doc """
  Gets a single title.

  Raises `Ecto.NoResultsError` if the Title does not exist.

  ## Examples

      iex> get_title!(123)
      %Title{}

      iex> get_title!(456)
      ** (Ecto.NoResultsError)

  """
  def get_title!(id), do: Repo.get!(Title, id)

  @doc """
  Creates a title.

  ## Examples

      iex> create_title(%{field: value})
      {:ok, %Title{}}

      iex> create_title(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_title(attrs \\ %{}) do
    %Title{}
    |> Title.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a title.

  ## Examples

      iex> update_title(title, %{field: new_value})
      {:ok, %Title{}}

      iex> update_title(title, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_title(%Title{} = title, attrs) do
    title
    |> Title.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a title.

  ## Examples

      iex> delete_title(title)
      {:ok, %Title{}}

      iex> delete_title(title)
      {:error, %Ecto.Changeset{}}

  """
  def delete_title(%Title{} = title) do
    Repo.delete(title)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking title changes.

  ## Examples

      iex> change_title(title)
      %Ecto.Changeset{data: %Title{}}

  """
  def change_title(%Title{} = title, attrs \\ %{}) do
    Title.changeset(title, attrs)
  end

  alias IMDbData.Movies.Alias

  @doc """
  Returns the list of aliases.

  ## Examples

      iex> list_aliases()
      [%Alias{}, ...]

  """
  def list_aliases do
    Repo.all(Alias)
  end

  @doc """
  Gets a single alias.

  Raises `Ecto.NoResultsError` if the Alias does not exist.

  ## Examples

      iex> get_alias!(123)
      %Alias{}

      iex> get_alias!(456)
      ** (Ecto.NoResultsError)

  """
  def get_alias!(id), do: Repo.get!(Alias, id)

  @doc """
  Creates a alias.

  ## Examples

      iex> create_alias(%{field: value})
      {:ok, %Alias{}}

      iex> create_alias(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_alias(attrs \\ %{}) do
    %Alias{}
    |> Alias.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a alias.

  ## Examples

      iex> update_alias(alias, %{field: new_value})
      {:ok, %Alias{}}

      iex> update_alias(alias, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_alias(%Alias{} = alias, attrs) do
    alias
    |> Alias.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a alias.

  ## Examples

      iex> delete_alias(alias)
      {:ok, %Alias{}}

      iex> delete_alias(alias)
      {:error, %Ecto.Changeset{}}

  """
  def delete_alias(%Alias{} = alias) do
    Repo.delete(alias)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking alias changes.

  ## Examples

      iex> change_alias(alias)
      %Ecto.Changeset{data: %Alias{}}

  """
  def change_alias(%Alias{} = alias, attrs \\ %{}) do
    Alias.changeset(alias, attrs)
  end

  alias IMDbData.Movies.Review

  @doc """
  Returns the list of reviews.

  ## Examples

      iex> list_reviews()
      [%Review{}, ...]

  """
  def list_reviews do
    Repo.all(Review)
  end

  @doc """
  Gets a single review.

  Raises `Ecto.NoResultsError` if the Review does not exist.

  ## Examples

      iex> get_review!(123)
      %Review{}

      iex> get_review!(456)
      ** (Ecto.NoResultsError)

  """
  def get_review!(id), do: Repo.get!(Review, id)

  @doc """
  Creates a review.

  ## Examples

      iex> create_review(%{field: value})
      {:ok, %Review{}}

      iex> create_review(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_review(attrs \\ %{}) do
    %Review{}
    |> Review.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a review.

  ## Examples

      iex> update_review(review, %{field: new_value})
      {:ok, %Review{}}

      iex> update_review(review, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_review(%Review{} = review, attrs) do
    review
    |> Review.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a review.

  ## Examples

      iex> delete_review(review)
      {:ok, %Review{}}

      iex> delete_review(review)
      {:error, %Ecto.Changeset{}}

  """
  def delete_review(%Review{} = review) do
    Repo.delete(review)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking review changes.

  ## Examples

      iex> change_review(review)
      %Ecto.Changeset{data: %Review{}}

  """
  def change_review(%Review{} = review, attrs \\ %{}) do
    Review.changeset(review, attrs)
  end
end

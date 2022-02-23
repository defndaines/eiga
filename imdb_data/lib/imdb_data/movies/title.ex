defmodule IMDbData.Movies.Title do
  @moduledoc """
  A movie title, which includes any of the type "short", "movie", "tvSeries", "tvMovie", or
  "tvMiniSeries". These are pulled from IMDb data, and the `tconst` is their unique identifier for
  a title.
  """

  use Ecto.Schema

  import Ecto.Changeset

  @primary_key {:tconst, :string, autogenerate: false}
  @derive {Phoenix.Param, key: :tconst}

  schema "titles" do
    field :adult, :boolean, default: false
    field :end_year, :integer
    field :genres, :string
    field :original_title, :string
    field :primary_title, :string
    field :runtime, :integer
    field :start_year, :integer
    field :type, :string

    has_many(
      :aliases,
      IMDbData.Movies.Alias,
      foreign_key: :tconst,
      on_delete: :delete_all
    )

    has_one(
      :reviews,
      IMDbData.Movies.Review,
      foreign_key: :tconst,
      on_delete: :delete_all
    )

    timestamps()
  end

  @doc false
  def changeset(title, attrs) do
    keys = __schema__(:fields)

    title
    |> cast(attrs, keys)
    |> validate_required([:tconst, :type, :primary_title, :original_title])
    |> validate_start_year()
    |> validate_end_year()
  end

  @doc """
  Cinema began in 1874 with "Passage de Vénus".
  """
  def validate_start_year(changeset) do
    validate_change(changeset, :start_year, fn :start_year, value ->
      if value < 1874 do
        [start_year: "earliest known film is from 1874"]
      else
        []
      end
    end)
  end

  @doc """
  The first identifier series was "Iz iskry plamya", 1924-1925.
  """
  def validate_end_year(changeset) do
    validate_change(changeset, :end_year, fn :end_year, value ->
      if value < 1925 do
        [end_year: "serial content was not produced before 1924"]
      else
        []
      end
    end)
  end
end

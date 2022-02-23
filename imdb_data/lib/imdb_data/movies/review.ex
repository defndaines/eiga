defmodule IMDbData.Movies.Review do
  @moduledoc """
  Accumulated rating average review for a given title, including the number of votes used to
  arrive at the rating.
  """

  use Ecto.Schema

  import Ecto.Changeset

  schema "reviews" do
    belongs_to(
      :titles,
      IMDbData.Movies.Title,
      foreign_key: :tconst,
      references: :tconst,
      type: :string
    )

    field :rating, :float
    field :votes, :integer

    timestamps()
  end

  @doc false
  def changeset(review, attrs) do
    keys = __schema__(:fields)

    review
    |> cast(attrs, keys)
    |> validate_required([:tconst, :rating, :votes])
    |> validate_rating()
    |> validate_votes()
  end

  @doc """
  `:rating` on a 0-10 scale, so value must be between 0.0 and 10.0 inclusive.
  """
  def validate_rating(changeset) do
    validate_change(changeset, :rating, fn :rating, value ->
      cond do
        value > 10.0 -> [rating: "cannot be greater than 10.0"]
        value < 0.0 -> [rating: "cannot be less than 0.0"]
        true -> []
      end
    end)
  end

  @doc """
  `:votes` must be a non-negative value when present.
  """
  def validate_votes(changeset) do
    validate_change(changeset, :votes, fn :votes, value ->
      if value < 0 do
        [votes: "cannot be a negative number"]
      else
        []
      end
    end)
  end
end

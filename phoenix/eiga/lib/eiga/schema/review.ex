defmodule Eiga.Schema.Review do
  @moduledoc """
  Repository schema for movie viewings and accompanying reviews.
  """

  use Ecto.Schema

  @type t :: %__MODULE__{
          review_id: UUID.t(),
          short_title: String.t(),
          location: String.t(),
          view_date: Date.t(),
          text: String.t()
        }

  @primary_key {:review_id, Ecto.UUID, autogenerate: true}

  schema "reviews" do
    belongs_to(
      :movie,
      Eiga.Schema.Movie,
      foreign_key: :short_title,
      references: :short_title,
      type: :string
    )

    field :location, :string
    field :view_date, :date
    field :text, :string

    timestamps()
  end

  def changeset(record, params \\ %{}) do
    keys = __schema__(:fields) -- [:created_at, :inserted_at]

    record
    |> Ecto.Changeset.cast(params, keys)
    |> Ecto.Changeset.validate_required([:short_title, :location, :view_date, :text])
  end
end

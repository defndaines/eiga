defmodule Eiga.Schema.Movie do
  @moduledoc """
  Repository schema for movies.
  """

  use Ecto.Schema

  @type t :: %__MODULE__{
          movie_id: UUID.t(),
          short_title: String.t(),
          title: String.t(),
          year: pos_integer(),
          country: String.t()
        }

  @primary_key {:movie_id, Ecto.UUID, autogenerate: true}

  schema "movies" do
    field :short_title, :string
    field :title, :string
    field :year, :integer
    field :country, :string

    has_many :reviews, {"reviews", Eiga.Schema.Review},
      foreign_key: :short_title,
      references: :short_title

    timestamps()
  end

  def changeset(record, params \\ %{}) do
    keys = __schema__(:fields) -- [:created_at, :inserted_at]

    record
    |> Ecto.Changeset.cast(params, keys)
    |> Ecto.Changeset.validate_required([:short_title, :title, :year, :country])
  end
end

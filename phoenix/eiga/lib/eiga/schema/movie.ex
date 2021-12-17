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

    timestamps()
  end

  def changeset(record, params \\ %{}) do
    keys = __schema__(:fields) -- [:created_at, :inserted_at]

    # TODO: Revisit after data import, maybe year and country can be required, too.
    record
    |> Ecto.Changeset.cast(params, keys)
    |> Ecto.Changeset.validate_required([:short_title, :title])
  end
end
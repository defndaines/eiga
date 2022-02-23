defmodule IMDbData.People.Person do
  @moduledoc """
  Schema for a person involved in a film. Includes everything from "director" or "actor" to
  "talent_agent" or "composer".
  """

  use Ecto.Schema

  import Ecto.Changeset

  @primary_key {:nconst, :string, autogenerate: false}
  @derive {Phoenix.Param, key: :nconst}

  schema "people" do
    field :birth_year, :integer
    field :death_year, :integer
    field :name, :string
    field :professions, :string

    timestamps()
  end

  @doc false
  def changeset(person, attrs) do
    keys = __schema__(:fields)

    person
    |> cast(attrs, keys)
    |> validate_required([:nconst, :name, :professions])
  end
end

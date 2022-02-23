defmodule IMDbData.Movies.Alias do
  @moduledoc """
  Alternative aliases for a title. This is typically the name given to a film when released in a
  different language or region.
  """

  use Ecto.Schema

  import Ecto.Changeset

  schema "aliases" do
    belongs_to(
      :titles,
      IMDbData.Movies.Title,
      foreign_key: :tconst,
      references: :tconst,
      type: :string
    )

    field :attributes, :string
    field :language, :string
    field :region, :string
    field :title, :string
    field :types, :string

    timestamps()
  end

  @doc false
  def changeset(alias, attrs) do
    keys = __schema__(:fields)

    alias
    |> cast(attrs, keys)
    |> validate_required([:tconst, :title])
  end
end

defmodule Eiga.Movie do
  use Ecto.Model

  schema "movie" do
    has_many :review, Eiga.Review
    field :title, :string
    field :short_title, :string
    field :year, :integer
    field :country, :string
  end
end

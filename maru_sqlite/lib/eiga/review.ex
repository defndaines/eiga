defmodule Eiga.Review do
  use Ecto.Model

  schema "review" do
    belongs_to :movie, Eiga.Movie
    field :location, :string
    field :view_date, Ecto.Date
    field :text, :string
  end
end

defmodule Eiga.Repo.Migrations.CreateReview do
  use Ecto.Migration

  def change do
    create table(:review) do
      add :movie_id, references(:movie)
      add :location, :string
      add :view_date, :date
      add :text, :string
    end
  end
end

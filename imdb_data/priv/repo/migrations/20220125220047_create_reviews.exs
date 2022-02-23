defmodule IMDbData.Repo.Migrations.CreateReviews do
  use Ecto.Migration

  def change do
    create table(:reviews) do
      add :tconst, :string
      add :rating, :float
      add :votes, :integer

      timestamps()
    end
  end
end

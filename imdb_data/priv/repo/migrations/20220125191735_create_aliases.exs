defmodule IMDbData.Repo.Migrations.CreateAliases do
  use Ecto.Migration

  def change do
    create table(:aliases) do
      add :tconst, references(:titles, column: :tconst, type: :string), null: false
      add :title, :string, null: false
      add :region, :string
      add :language, :string
      add :types, :string
      add :attributes, :string

      timestamps()
    end
  end
end
